node = Node.create!(title: 'root_node')
node2 = Node.create!(title: 'node2', parent_node_id: node.id)
Node.create!(title: 'node4', parent_node_id: node2.id)
Node.create!(title: 'node5', parent_node_id: node2.id)
node3 = Node.create!(title: 'node3', parent_node_id: node2.id)
Node.create!(title: 'another_root')

Element.create!(title: 'element', node_id: node.id)
Element.create!(title: 'element1', node_id: node2.id)
Element.create!(title: 'element2', node_id: node.id)

Element.create!(title: 'element3', node_id: node3.id)
Element.create!(title: 'element4', node_id: node3.id)
Element.create!(title: 'element5', node_id: node3.id)