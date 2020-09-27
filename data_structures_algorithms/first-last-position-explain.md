
### Find First and Last Position of Element in Sorted Array   
Given an array of integers nums sorted in ascending order, find the starting and ending position of a given target value.

Your algorithm's runtime complexity must be in the order of O(log n).

If the target is not found in the array, return [-1, -1].

#### Example 1:

Input: nums = [5,7,7,8,8,10], target = 8   

Output: [3,4]

#### Example 2:

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
            
            
            # found (binary search - see note 1 below)
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

> Binary Search - In computer science, binary search, also known as half-interval search,[1] logarithmic search,[2] or binary chop,[3] is a search algorithm that finds the position of a target value within a sorted array.[4][5] Binary search compares the target value to the middle element of the array. If they are not equal, the half in which the target cannot lie is eliminated and the search continues on the remaining half, again taking the middle element to compare to the target value, and repeating this until the target value is found. If the search ends with the remaining half being empty, the target is not in the array.

Binary search runs in logarithmic time in the worst case, making {\displaystyle O(\log n)}O(\log n) comparisons, where {\displaystyle n}n is the number of elements in the array, the {\displaystyle O}O is Big O notation, and {\displaystyle \log }\log  is the logarithm.[6] Binary search is faster than linear search except for small arrays. However, the array must be sorted first to be able to apply binary search. There are specialized data structures designed for fast searching, such as hash tables, that can be searched more efficiently than binary search. However, binary search can be used to solve a wider range of problems, such as finding the next-smallest or next-largest element in the array relative to the target even if it is absent from the array.

There are numerous variations of binary search. In particular, fractional cascading speeds up binary searches for the same value in multiple arrays. Fractional cascading efficiently solves a number of search problems in computational geometry and in numerous other fields. Exponential search extends binary search to unbounded lists. The binary search tree and B-tree data structures are based on binary search.   

https://en.wikipedia.org/wiki/Binary_search_algorithm   


