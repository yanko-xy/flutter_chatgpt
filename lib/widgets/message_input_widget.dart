import 'package:flutter/material.dart';

class MessageInputWidget extends StatefulWidget {
  final ValueChanged? onChanged;
  final VoidCallback? onSend;
  final String hint;
  final bool enable;

  const MessageInputWidget(
      {super.key, this.onChanged, this.onSend, required this.hint, this.enable = true});

  @override
  State<MessageInputWidget> createState() => _MessageInputWidgetState();
}

class _MessageInputWidgetState extends State<MessageInputWidget> {
  bool _showSend = false;
  final _controller = TextEditingController();

  get _input => Expanded(
          child: TextField(
        onChanged: _onChanged,
        controller: _controller,
        style: const TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w400),
        // 输入框的样式
        decoration: InputDecoration(
          border: OutlineInputBorder(
            // 设置填充圆角
            borderRadius: BorderRadius.circular(6),
            // 取消边框
            borderSide: const BorderSide(width: 0, style: BorderStyle.none),
          ),
          filled: true,
          fillColor: Colors.white,
          // 输入框样式的大小约束
          constraints: const BoxConstraints(maxHeight: 39),
          contentPadding: const EdgeInsets.only(left: 10),
          hintStyle: const TextStyle(fontSize: 16),
          hintText: widget.hint,
        ),
      ));

  get _sendBtn => Container(
        margin: const EdgeInsets.only(left: 10),
        width: 65,
        child: MaterialButton(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          height: 35,
          disabledColor: Colors.blue.withOpacity(0.6),
          color: Colors.blue,
          onPressed: widget.enable ? _onSend : null,
          child: const Text(
            "发送",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    var bottom = MediaQuery.of(context).padding.bottom;
    if (bottom == 0.0) {
      // 适配ios刘海屏以外的设备
      bottom = 20;
    }
    return Container(
      height: 50 + bottom,
      padding: EdgeInsets.only(left: 20, right: 20, top: 5, bottom: bottom),
      decoration: BoxDecoration(color: Colors.grey.withOpacity(0.2)),
      child: Row(
        children: [_input, if (_showSend) _sendBtn],
      ),
    );
  }

  void _onChanged(String value) {
    if (widget.onChanged != null) widget.onChanged!(value);
    setState(() {
      _showSend = value.isNotEmpty;
    });
  }

  void _onSend() {
    if (widget.onSend != null) {
      widget.onSend!();
      _controller.clear();
      setState(() {
        _showSend = false;
      });
    }
  }
}
