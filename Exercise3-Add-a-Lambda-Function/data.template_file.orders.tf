data "template_file" "orders" {
  template = "${file("${path.module}/templates/${var.intentsfile}.json.tpl")}"

  vars {
    region     = "${var.region}"
    account_id = "${data.aws_caller_identity.current.account_id}"
  }
}

resource "local_file" "orders" {
  content  = "${data.template_file.orders.rendered}"
  filename = "${path.module}/${var.intentsfile}.json"
}
