import 'package:neumorphic_ui/neumorphic_ui.dart';

class ProductQuantityPickerWidget extends StatefulWidget {
  const ProductQuantityPickerWidget({
    super.key,
    required this.productQuantity,
    required this.increaseAmountProduct,
    required this.decreaseAmountProduct,
  });

  final int productQuantity;
  final VoidCallback increaseAmountProduct;
  final VoidCallback decreaseAmountProduct;

  @override
  State<ProductQuantityPickerWidget> createState() =>
      _ProductQuantityPickerWidgetState();
}

class _ProductQuantityPickerWidgetState
    extends State<ProductQuantityPickerWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade400.withOpacity(0.2),
            spreadRadius: 12,
            blurRadius: 16,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Flexible(
            child: Text(
              "Escolha a quantidadede de produtos:",
              softWrap: true,
              style: TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(width: 20),
          Row(
            children: [
              ButtonWidget(
                actionName: "Remover",
                icon: Icons.remove,
                function: widget.decreaseAmountProduct,
              ),
              const SizedBox(width: 8),
              Text(
                "${widget.productQuantity}",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 8),
              ButtonWidget(
                actionName: "Adicionar",
                icon: Icons.add,
                function: widget.increaseAmountProduct,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    super.key,
    required this.actionName,
    required this.icon,
    required this.function,
  });

  final String actionName;
  final IconData icon;
  final VoidCallback function;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: actionName,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: NeumorphicButton(
          onPressed: () => function(),
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
