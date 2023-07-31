import 'package:neumorphic_ui/neumorphic_ui.dart';

class ProductQuantityPickerWidget extends StatefulWidget {
  const ProductQuantityPickerWidget({
    super.key,
    required this.productQuantity,
    required this.updateProductPrice,
  });

  final int productQuantity;
  final void Function(int) updateProductPrice;

  @override
  State<ProductQuantityPickerWidget> createState() =>
      _ProductQuantityPickerWidgetState();
}

class _ProductQuantityPickerWidgetState
    extends State<ProductQuantityPickerWidget> {
  void increaseAmountProduct() {
    int productQuantity = widget.productQuantity;
    if (productQuantity < 20) {
      final int newQuantity = productQuantity + 1;
      widget.updateProductPrice(newQuantity);
    }
  }

  void decreaseAmountProduct() {
    int productQuantity = widget.productQuantity;
    if (productQuantity > 1) {
      final int newQuantity = productQuantity - 1;
      widget.updateProductPrice(newQuantity);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ButtonWidget(
          actionName: "Remover",
          icon: Icons.remove,
          productQuantity: widget.productQuantity,
          function: decreaseAmountProduct,
        ),
        const SizedBox(width: 8),
        Text(
          widget.productQuantity.toString(),
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(width: 8),
        ButtonWidget(
          actionName: "Adicionar",
          icon: Icons.add,
          productQuantity: widget.productQuantity,
          function: increaseAmountProduct,
        ),
      ],
    );
  }
}

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    super.key,
    required this.actionName,
    required this.icon,
    required this.productQuantity,
    required this.function,
  });

  final String actionName;
  final IconData icon;
  final int productQuantity;
  final VoidCallback function;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: actionName,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: NeumorphicButton(
          onPressed: function,
          padding: const EdgeInsets.all(3),
          style: NeumorphicStyle(
            color: Colors.grey.shade50,
            shape: NeumorphicShape.concave,
            boxShape: const NeumorphicBoxShape.circle(),
          ),
          child: NeumorphicIcon(
            icon,
            size: 18,
            style: NeumorphicStyle(
              color: Colors.grey.shade800,
            ),
          ),
        ),
      ),
    );
  }
}
