# A Tic Tac Toe command line program
Written in Ruby

Aiming to build a perfect tic-tac-toe playing AI

just cuz.

### Read here about the minimax algorithm
- https://towardsdatascience.com/tic-tac-toe-creating-unbeatable-ai-with-minimax-algorithm-8af9e52c1e7d

### TODOS
Things to try
- now that I have a class to build up the whole game tree, try doing a breadth-first (?) search through it to score up each node based on each node's children
  - Aha! So even if a node in the tree does not itself have its own `x_score`, it could have a `derived_x_score` based on the `x_score`s of the terminal nodes in its sub-tree.
  - And this `derived_x_score` could be determined via a minimax algorithm. Insofar as I undersand the idea of that, it means that if any nodes result in a loss for the protagonist, avoid the parent node completely.
