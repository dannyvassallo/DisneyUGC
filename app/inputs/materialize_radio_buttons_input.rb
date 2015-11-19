class MaterializeRadioButtonsInput < SimpleForm::Inputs::CollectionRadioButtonsInput

  # Creates a radio button set for use with Materialize CSS

  def input
    label_method, value_method = detect_collection_methods
    iopts = {
      :checked => 1,
      :item_wrapper_class => 'field',
      :collection_wrapper_class => 'grouped inline fields'
     }
    return @builder.send(
      "collection_radio_buttons",
      attribute_name,
      collection,
      value_method,
      label_method,
      iopts,
      input_html_options,
      &collection_block_for_nested_boolean_style
    )
  end # method

  protected

  def build_nested_boolean_style_item_tag(collection_builder)
    tag = String.new
    tag << '<p>'.html_safe
    tag << collection_builder.radio_button + collection_builder.label
    tag << '</p>'.html_safe
    return tag.html_safe
  end # method

end # class