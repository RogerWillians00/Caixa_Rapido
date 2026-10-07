import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

import '../app_Controlers/darktheme.dart';

class InventoryScreen extends StatefulWidget {
  const InventoryScreen({Key? key}) : super(key: key);

  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  // ================================================================
  // VARIAVEIS DE ESTADO
  // ================================================================
  final List<_Product> _products = [];
  final TextEditingController _searchController = TextEditingController();
  String _searchText = '';

  // ================================================================
  // METODO: Abrir o formulario para cadastrar ou editar um produto
  // ================================================================
  Future<void> _openProductForm({_Product? product}) async {
    final updatedProduct = await showDialog<_Product>(
      context: context,
      builder: (context) => _ProductFormDialog(product: product),
    );

    if (updatedProduct == null || !mounted) return;

    setState(() {
      if (product == null) {
        _products.add(updatedProduct);
      } else {
        final index = _products.indexOf(product);
        if (index != -1) _products[index] = updatedProduct;
      }
    });
  }

  // ================================================================
  // METODO: Confirmar a remocao de um produto
  // ================================================================
  Future<void> _removeProduct(_Product product) async {
    final shouldRemove = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Remover produto?'),
        content: Text('Deseja remover "${product.name}" do estoque?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Remover'),
          ),
        ],
      ),
    );

    if (shouldRemove == true && mounted) {
      setState(() => _products.remove(product));
    }
  }

  // ================================================================
  // METODO: Exibir aviso para uma tela que ainda sera criada
  // ================================================================
  void _showComingSoonMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Esta tela estará disponível em breve.')),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // ================================================================
  // METODO: Montar a tela de estoque
  // ================================================================
  @override
  Widget build(BuildContext context) {
    final themeProvider = ThemeProvider.of(context);
    final filteredProducts = _products.where((product) {
      return product.name.toLowerCase().contains(_searchText.toLowerCase());
    }).toList();
    final totalItems = _products.fold<int>(
      0,
      (total, product) => total + product.quantity,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Estoque'),
        centerTitle: false,
        backgroundColor: const Color(0xFF1E5727),
        foregroundColor: Colors.white,
        actions: [
          if (themeProvider != null)
            IconButton(
              tooltip: 'Alternar tema',
              icon: Icon(
                themeProvider.isDarkTheme
                    ? Icons.wb_sunny_outlined
                    : Icons.nightlight_round,
              ),
              onPressed: () => themeProvider.toggleTheme(),
            ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ============================================================
              // SECAO: RESUMO DO ESTOQUE
              // ============================================================
              Text(
                'Gerencie seus produtos',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 5),
              Text(
                'Cadastre produtos, preços e quantidades.',
                style: TextStyle(color: Theme.of(context).hintColor),
              ),
              const SizedBox(height: 18),
              _buildSummaryCard(context, _products.length, totalItems),
              const SizedBox(height: 18),

              // ============================================================
              // SECAO: BUSCA E CADASTRO
              // ============================================================
              TextField(
                controller: _searchController,
                onChanged: (value) => setState(() => _searchText = value),
                decoration: InputDecoration(
                  hintText: 'Buscar produto',
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.surface,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () => _openProductForm(),
                  icon: const Icon(Icons.add),
                  label: const Text('Cadastrar produto'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1E5727),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // ============================================================
              // SECAO: LISTA DE PRODUTOS
              // ============================================================
              Text(
                'Produtos cadastrados',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: filteredProducts.isEmpty
                    ? _buildEmptyState(context)
                    : ListView.separated(
                        itemCount: filteredProducts.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 10),
                        itemBuilder: (context, index) {
                          final product = filteredProducts[index];
                          return _buildProductCard(context, product);
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildNavigationBar(context),
    );
  }

  // ================================================================
  // WIDGET: Cartao com o resumo do estoque
  // ================================================================
  Widget _buildSummaryCard(
      BuildContext context, int productCount, int itemCount) {
    final totalValue = _products.fold<double>(
      0,
      (total, product) => total + product.price * product.quantity,
    );

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFEAF3EB),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              color: Color(0xFFD3E8D5),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: SvgPicture.asset(
              'assets/images/inventoryIcon.svg',
              width: 22,
              height: 22,
              colorFilter: const ColorFilter.mode(
                Color(0xFF1E5727),
                BlendMode.srcIn,
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$productCount produtos  •  $itemCount unidades',
                  style: const TextStyle(
                    color: Color(0xFF1E5727),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Valor em estoque: R\$ ${totalValue.toStringAsFixed(2).replaceAll('.', ',')}',
                  style: const TextStyle(color: Color(0xFF476B4B)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ================================================================
  // WIDGET: Cartao de um produto
  // ================================================================
  Widget _buildProductCard(BuildContext context, _Product product) {
    final lowStock = product.quantity <= 5;

    return Card(
      margin: EdgeInsets.zero,
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.fromLTRB(14, 6, 4, 6),
        leading: SizedBox(
          width: 48,
          height: 48,
          child: product.imageBytes != null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.memory(
                    product.imageBytes!,
                    fit: BoxFit.cover,
                  ),
                )
              : CircleAvatar(
                  backgroundColor: lowStock
                      ? const Color(0xFFFFF0D6)
                      : const Color(0xFFEAF3EB),
                  child: Icon(
                    Icons.inventory_2_outlined,
                    color: lowStock
                        ? const Color(0xFFAE7000)
                        : const Color(0xFF1E5727),
                  ),
                ),
        ),
        title: Text(
          product.name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Text(
            'R\$ ${product.price.toStringAsFixed(2).replaceAll('.', ',')}'
            '  •  ${product.quantity} unidades'
            '${lowStock ? '  •  Estoque baixo' : ''}',
            style: TextStyle(
              color: lowStock ? const Color(0xFFAE7000) : null,
            ),
          ),
        ),
        trailing: PopupMenuButton<String>(
          tooltip: 'Ações do produto',
          onSelected: (action) {
            if (action == 'edit') _openProductForm(product: product);
            if (action == 'remove') _removeProduct(product);
          },
          itemBuilder: (context) => const [
            PopupMenuItem(value: 'edit', child: Text('Editar')),
            PopupMenuItem(value: 'remove', child: Text('Remover')),
          ],
        ),
      ),
    );
  }

  // ================================================================
  // WIDGET: Estado vazio da lista
  // ================================================================
  Widget _buildEmptyState(BuildContext context) {
    final hasSearch = _searchText.trim().isNotEmpty;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              hasSearch ? Icons.search_off : Icons.inventory_2_outlined,
              size: 52,
              color: Theme.of(context).hintColor,
            ),
            const SizedBox(height: 12),
            Text(
              hasSearch
                  ? 'Nenhum produto encontrado.'
                  : 'Seu estoque ainda está vazio.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            if (!hasSearch) ...[
              const SizedBox(height: 6),
              Text(
                'Use “Cadastrar produto” para adicionar o primeiro item.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Theme.of(context).hintColor),
              ),
            ],
          ],
        ),
      ),
    );
  }

  // ================================================================
  // WIDGET: Barra de navegacao das telas do aplicativo
  // ================================================================
  Widget _buildNavigationBar(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: 1,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: const Color(0xFF1E5727),
      unselectedItemColor: Theme.of(context).hintColor,
      onTap: (index) {
        if (index != 1) _showComingSoonMessage();
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.point_of_sale_outlined),
          label: 'Caixa',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.inventory_2_outlined),
          label: 'Estoque',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.bar_chart_outlined),
          label: 'Relatórios',
        ),
      ],
    );
  }
}

// ================================================================
// WIDGET: Formulario para cadastrar ou editar produtos
// ================================================================
class _ProductFormDialog extends StatefulWidget {
  const _ProductFormDialog({this.product});

  final _Product? product;

  @override
  State<_ProductFormDialog> createState() => _ProductFormDialogState();
}

class _ProductFormDialogState extends State<_ProductFormDialog> {
  // ================================================================
  // VARIAVEIS DE ESTADO DO FORMULARIO
  // ================================================================
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _priceController;
  late final TextEditingController _quantityController;
  final ImagePicker _imagePicker = ImagePicker();
  Uint8List? _imageBytes;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.product?.name ?? '');
    _priceController = TextEditingController(
      text: widget.product?.price.toStringAsFixed(2).replaceAll('.', ',') ?? '',
    );
    _quantityController = TextEditingController(
      text: widget.product?.quantity.toString() ?? '',
    );
    _imageBytes = widget.product?.imageBytes;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _quantityController.dispose();
    super.dispose();
  }

  // ================================================================
  // METODO: Validar e salvar o produto
  // ================================================================
  void _saveProduct() {
    if (!_formKey.currentState!.validate()) return;

    final price =
        double.parse(_priceController.text.trim().replaceAll(',', '.'));
    final quantity = int.parse(_quantityController.text.trim());

    Navigator.pop(
      context,
      _Product(
        name: _nameController.text.trim(),
        price: price,
        quantity: quantity,
        imageBytes: _imageBytes,
      ),
    );
  }

  // ================================================================
  // METODO: Selecionar uma foto para o produto
  // ================================================================
  Future<void> _pickProductImage() async {
    try {
      final image = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );

      if (image == null) return;

      final imageBytes = await image.readAsBytes();
      if (!mounted) return;
      setState(() => _imageBytes = imageBytes);
    } on PlatformException {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Não foi possível selecionar a foto.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.product != null;

    return AlertDialog(
      title: Text(isEditing ? 'Editar produto' : 'Cadastrar produto'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // ============================================================
              // SECAO: FOTO DO PRODUTO
              // ============================================================
              InkWell(
                onTap: _pickProductImage,
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    border: Border.all(color: Theme.of(context).dividerColor),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: _imageBytes == null
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.add_a_photo_outlined, size: 30),
                            SizedBox(height: 6),
                            Text('Adicionar foto'),
                          ],
                        )
                      : Image.memory(_imageBytes!, fit: BoxFit.cover),
                ),
              ),
              if (_imageBytes != null)
                TextButton.icon(
                  onPressed: () => setState(() => _imageBytes = null),
                  icon: const Icon(Icons.delete_outline),
                  label: const Text('Remover foto'),
                ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _nameController,
                autofocus: true,
                textCapitalization: TextCapitalization.sentences,
                decoration: const InputDecoration(
                  labelText: 'Nome do produto',
                  prefixIcon: Icon(Icons.sell_outlined),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Informe o nome do produto.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _priceController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9,.]')),
                ],
                decoration: const InputDecoration(
                  labelText: 'Preço (R\$)',
                  prefixIcon: Icon(Icons.attach_money),
                ),
                validator: (value) {
                  final price =
                      double.tryParse(value?.trim().replaceAll(',', '.') ?? '');
                  if (price == null || price <= 0) {
                    return 'Informe um preço maior que zero.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _quantityController,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: const InputDecoration(
                  labelText: 'Quantidade em estoque',
                  prefixIcon: Icon(Icons.numbers),
                ),
                validator: (value) {
                  if (int.tryParse(value?.trim() ?? '') == null) {
                    return 'Informe uma quantidade válida.';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: _saveProduct,
          child: Text(isEditing ? 'Salvar' : 'Cadastrar'),
        ),
      ],
    );
  }
}

// ================================================================
// MODELO: Dados de um produto no estoque
// ================================================================
class _Product {
  const _Product({
    required this.name,
    required this.price,
    required this.quantity,
    this.imageBytes,
  });

  final String name;
  final double price;
  final int quantity;
  final Uint8List? imageBytes;
}
