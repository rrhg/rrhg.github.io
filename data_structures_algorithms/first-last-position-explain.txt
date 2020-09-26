
### Find First and Last Position of Element in Sorted Array   
Given an array of integers nums sorted in ascending order, find the starting and ending position of a given target value.

Your algorithm's runtime complexity must be in the order of O(log n).

If the target is not found in the array, return [-1, -1].

Example 1:

Input: nums = [5,7,7,8,8,10], target = 8
Output: [3,4]

Example 2:

Input: nums = [5,7,7,8,8,10], target = 6
Output: [-1,-1]

```
nums,target = [5,7,7,8,8,8,10], 8
class Solution:
    def searchRange(self, nums: List[int], target: int) -> List[int]:
        L, H = 0, len(nums)       
        while L < H:
            
            #M = (L + H) // 2 
            M = L + (H - L) // 2 # to prevent overflow
            
            # found
            if nums[M] == target: #found. Now look both sides & return both indexes
                L, H = M, M
                
                #   <---   searching leftmost index
                while (
                    L - 1 >= 0   # have not reach left end
                    and 
                    nums[L - 1] == target  # left item == target
                ):
                    L -= 1
                
                #   --->    searching rightmost index
                while (
                    H + 1 < len(nums)  # have not reach right end
                    and 
                    nums[H + 1] == target  # right item == target
                ):
                    H += 1
                return [L, H] # leftmost, rightmost indexes which values == target
            
            
            # did NOT found target
            elif target > nums[M]: #target is not in M, & is higher, so search right side of M
                L = M + 1
            elif target < nums[M]: #target is not in M, & is lower, so search left side of M
                H = M        
                
        return [-1, -1] # target not in list
s = Solution()
print(s.searchRange(nums,target))

```   

