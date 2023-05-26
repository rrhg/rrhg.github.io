
Why install cuda?
- EasyOCR & other Model training software use PyTorch.
- PyTorch use Cuda (Nvidia software) to be able to use the GPU instead of the CPU

How know if is working?

import torch
torch.cuda.is_available() # True
torch.cuda.device_count() # 1
torch.cuda.current_device() # 0
torch.cuda.device(0) # torch.cuda.device at 0x7efce0b03be0>
torch.cuda.get_device_name(0) # 'GeForce GTX 950M'
