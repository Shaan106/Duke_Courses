import numpy as np

import matplotlib.pyplot as pyplot

gcc_inorder = [0.6096,0.5887,0.5659]
go_inorder = [0.3926,0.3734,0.3555]

gcc_4ruu = [0.6622,0.6249,0.5902]
go_4ruu = [0.5864,0.5737,0.5582]

gcc_32ruu = [0.9440,0.9293,0.9114]
go_32ruu = [0.8950,0.8829,0.8676]


# plot all on same graph

# x axis is cache latency
# y axis is IPC
pyplot.plot(gcc_inorder, label='gcc_inorder')
pyplot.plot(go_inorder, label='go_inorder')
pyplot.plot(gcc_4ruu, label='gcc_4ruu')
pyplot.plot(go_4ruu, label='go_4ruu')
pyplot.plot(gcc_32ruu, label='gcc_32ruu')
pyplot.plot(go_32ruu, label='go_32ruu')

pyplot.xlabel('Cache Latency')
pyplot.ylabel('IPC')

pyplot.legend(loc='center left', bbox_to_anchor=(1, 0.5))
pyplot.grid(True)
pyplot.tight_layout()
pyplot.show()
