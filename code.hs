import Test.Hspec

-- Use the following data types for the questions below
data Tree a = Nil | TreeNode (Tree a) a (Tree a) deriving (Show, Eq)

data LinkedList a = Null | ListNode a (LinkedList a) deriving (Show, Eq) 

-- Category: Easy

-- Question 1
swapFinal :: [Int] -> [Int]
swapFinal [x, y] = if x >= y then [x, y] else [y, x]

targetSum :: [Int] -> Int -> [[Int]]
targetSum arr target = sortFunc [swapFinal [x, y] | (x : ys) <- returnTail arr, y <- ys, x + y == target]

returnTail :: [a] -> [[a]]
returnTail [] = [[]]
returnTail (x : xs) = (x : xs) : returnTail xs

sortFunc :: (Ord a) => [a] -> [a]
sortFunc [] = []
sortFunc (x : xs) =
  let greater = sortFunc [a | a <- xs, a >= x]
      smaller = sortFunc [a | a <- xs, a < x]
   in smaller ++ [x] ++ greater

-- Question 2
symmetricTree :: Eq a => Tree a -> Bool
symmetricTree Nil = True
symmetricTree (TreeNode left val right) = symCheck left right

-- ST here refers to SubTree
symCheck :: Eq a => Tree a -> Tree a -> Bool
symCheck Nil Nil = True
symCheck (TreeNode leftST1 value1 rightST1) (TreeNode leftST2 value2 rightST2) =
  value1 == value2 && symCheck leftST1 rightST2 && symCheck rightST1 leftST2
symCheck _ _ = False


-- Question 3
-- Convert LinkedList to List
linkedToList :: LinkedList a -> [a]
linkedToList Null = []
linkedToList (ListNode x rest) = x : linkedToList rest

palindromCheck :: (Eq a) => [a] -> Bool
palindromCheck xs = xs == reverseCustom xs

palindromList :: Eq a => LinkedList a -> Bool
palindromList list = palindromCheck (linkedToList list)

reverseCustom :: [a] -> [a]
reverseCustom [] = []
reverseCustom (x : xs) = reverseCustom xs ++ [x]

-- Question 4
concatMapCustom :: (a -> [b]) -> [a] -> [b]
concatMapCustom _ [] = []
concatMapCustom f (x : xs) = f x ++ concatMapCustom f xs

snakeTraversal :: Tree a -> [a]
snakeTraversal tree = stHelper [tree] True

stHelper :: [Tree a] -> Bool -> [a]
stHelper [] _ = []
stHelper nodes left2Right =
  let nextNodes = concatMapCustom getChildren nodes
   in getNodeValues nodes left2Right ++ stHelper nextNodes (not left2Right)

getNodeValues :: [Tree a] -> Bool -> [a]
getNodeValues [] _ = []
getNodeValues (Nil : rest) left2Right = getNodeValues rest left2Right
getNodeValues (TreeNode left val right : rest) left2Right =
  if left2Right
    then val : getNodeValues rest left2Right
    else getNodeValues rest left2Right ++ [val]

getChildren :: Tree a -> [Tree a] 

getChildren Nil = []
getChildren (TreeNode left _ right) = [left, right]
-- Question 5
treeConstruction :: String -> Tree Char
treeConstruction = undefined

-- Category: Medium

-- Attempy any 4 questions from this category

-- Question 1.1: Overload the (+) operator for Tree. You only need to overload (+). Keep the rest of the operators as undefined.
instance Num (Tree Int) where
  (+) = addTreeNode
  (*) = undefined
  abs = undefined
  signum = undefined
  fromInteger = undefined
  negate = undefined

addTreeNode :: (Num a) => Tree a -> Tree a -> Tree a
addTreeNode Nil n = n
addTreeNode n Nil = n
addTreeNode (TreeNode leftST1 value1 rightST1) (TreeNode leftST2 value2 rightST2) =
    TreeNode (addTreeNode leftST1 leftST2) (value1 + value2) (addTreeNode rightST1 rightST2)
  
-- Question 1.2

longestCommonString :: LinkedList Char -> LinkedList Char -> LinkedList Char
longestCommonString = undefined

-- Question 2
commonAncestor :: (Eq a) => Tree a -> a -> a -> Maybe a
commonAncestor = undefined

-- Question 3
gameofLife :: [[Int]] -> [[Int]]
gameofLife = undefined

-- Question 4
waterCollection :: [Int] -> Int
waterCollection = undefined

-- Question 5
minPathMaze :: [[Int]] -> Int
minPathMaze = undefined

-- Main Function
main :: IO ()
main =
   hspec $ do
  -- Test List Target Sum
      describe "targetSum" $ do
          it "should return pairs whose sum is equal to the target" $ do
              targetSum [1,2,3,4,5] 5 `shouldBe` [[3,2], [4,1]]
              targetSum [1,2,3,4,5,6] 10 `shouldBe` [[6,4]]
              targetSum [1,2,3,4,5] 0 `shouldBe` []
              targetSum [1,10,8,7,6,2,3,4,5,-1,9] 10 `shouldBe` [[6,4],[7,3],[8,2],[9,1]]
  
  -- Test Symmetric Tree
      describe "symmetricTree" $ do
        it "should return True if the tree is symmetric" $ do
              -- symmetricTree Nil `shouldBe` True
              symmetricTree (TreeNode (TreeNode Nil 1 Nil) 2 (TreeNode Nil 1 Nil)) `shouldBe` True
              symmetricTree (TreeNode (TreeNode Nil 1 Nil) 2 (TreeNode Nil 2 Nil)) `shouldBe` False
              symmetricTree (TreeNode (TreeNode (TreeNode Nil 1 Nil) 2 (TreeNode Nil 3 Nil)) 4 (TreeNode (TreeNode Nil 3 Nil) 2 (TreeNode Nil 1 Nil))) `shouldBe` True
              symmetricTree (TreeNode (TreeNode (TreeNode Nil 1 Nil) 2 (TreeNode Nil 3 Nil)) 4 (TreeNode (TreeNode Nil 3 Nil) 2 (TreeNode Nil 4 Nil))) `shouldBe` False
  
  -- Test Palindrom List
      describe "palindromList" $ do
          it "should return True if the list is a palindrome" $ do
              -- palindromList Null `shouldBe` True
              palindromList (ListNode 1 (ListNode 2 (ListNode 3 (ListNode 2 (ListNode 1 Null))))) `shouldBe` True
              palindromList (ListNode 1 (ListNode 2 (ListNode 3 (ListNode 3 (ListNode 1 Null))))) `shouldBe` False
              palindromList (ListNode 1 (ListNode 2 (ListNode 3 (ListNode 2 (ListNode 2 Null))))) `shouldBe` False
              palindromList (ListNode 1 (ListNode 2 (ListNode 3 (ListNode 2 (ListNode 1 (ListNode 1 Null)))))) `shouldBe` False
              palindromList (ListNode 'a' (ListNode 'b' (ListNode 'c' (ListNode 'b' (ListNode 'a' Null))))) `shouldBe` True
              palindromList (ListNode 'a' (ListNode 'b' (ListNode 'c' (ListNode 'c' (ListNode 'a' Null))))) `shouldBe` False
  
  -- Test Snake Traversal
      describe "snakeTraversal" $ do
          it "should return the snake traversal of the tree" $ do
              snakeTraversal (Nil:: Tree Int) `shouldBe` []
              snakeTraversal (TreeNode (TreeNode Nil 1 Nil) 2 (TreeNode Nil 3 Nil)) `shouldBe` [2,3,1]
              snakeTraversal (TreeNode (TreeNode (TreeNode Nil 1 Nil) 3 (TreeNode Nil 6 Nil)) 4 (TreeNode (TreeNode Nil 5 Nil) 2 (TreeNode Nil 7 Nil))) `shouldBe` [4,2,3,1,6,5,7]
              snakeTraversal (TreeNode (TreeNode (TreeNode Nil 1 Nil) 3 (TreeNode Nil 6 Nil)) 4 (TreeNode (TreeNode Nil 5 Nil) 2 (TreeNode (TreeNode Nil 9 Nil) 7 Nil))) `shouldBe` [4,2,3,1,6,5,7,9]
  
  -- Test Tree Construction
      describe "treeConstruction" $ do
          it "should return the tree constructed from the string" $ do
              treeConstruction "" `shouldBe` Nil
              treeConstruction "a" `shouldBe` TreeNode Nil 'a' Nil
              treeConstruction "^a" `shouldBe` Nil
              treeConstruction "ab^c" `shouldBe` TreeNode (TreeNode Nil 'b' Nil) 'a' (TreeNode Nil 'c' Nil)
              treeConstruction "ab^c^" `shouldBe` TreeNode (TreeNode Nil 'b' Nil) 'a' (TreeNode Nil 'c' Nil)
              treeConstruction "ab^cde^f" `shouldBe` TreeNode (TreeNode Nil 'b' Nil) 'a' (TreeNode (TreeNode (TreeNode Nil 'e' Nil) 'd' (TreeNode Nil 'f' Nil)) 'c' Nil)
              treeConstruction "abcde^f" `shouldBe` TreeNode (TreeNode (TreeNode (TreeNode (TreeNode Nil 'e' Nil) 'd' (TreeNode Nil 'f' Nil)) 'c' Nil) 'b' Nil) 'a' Nil
  
  -- Test (+) operator for Tree
      describe "(+)" $ do
          it "should return the sum of the two trees" $ do
              let result1 = (TreeNode (TreeNode Nil 1 Nil) 2 (TreeNode Nil 3 Nil) + TreeNode (TreeNode Nil 1 Nil) 2 (TreeNode Nil 3 Nil) :: Tree Int) 
              result1  `shouldBe` TreeNode (TreeNode Nil 2 Nil) 4 (TreeNode Nil 6 Nil) 
              let result2 = (TreeNode (TreeNode Nil 1 Nil) 2 (TreeNode Nil 3 Nil) + TreeNode Nil 2 (TreeNode Nil 3 Nil) :: Tree Int)
              result2 `shouldBe` TreeNode (TreeNode Nil 1 Nil) 4 (TreeNode Nil 6 Nil)
              let result3 = (Nil + Nil :: Tree Int) 
              result3 `shouldBe` Nil
              let result4 = (Nil + TreeNode (TreeNode Nil 1 Nil) 2 (TreeNode Nil 3 Nil):: Tree Int)
              result4 `shouldBe` TreeNode (TreeNode Nil 1 Nil) 2 (TreeNode Nil 3 Nil)
              let result5 = (TreeNode (TreeNode (TreeNode Nil 1 (TreeNode Nil (-2) Nil)) 3 Nil) 4 (TreeNode Nil 2 (TreeNode Nil 7 (TreeNode Nil (-7) Nil))) + TreeNode (TreeNode (TreeNode (TreeNode Nil 0 Nil) 1 Nil) 3 (TreeNode (TreeNode Nil 1 Nil) 6 (TreeNode Nil (-2) Nil))) 4 (TreeNode (TreeNode (TreeNode Nil 9 Nil) 5 (TreeNode Nil 4 Nil)) 2 (TreeNode (TreeNode Nil (-5) Nil) 7 Nil)) :: Tree Int) 
              result5 `shouldBe` TreeNode (TreeNode (TreeNode (TreeNode Nil 0 Nil) 2 (TreeNode Nil (-2) Nil)) 6 (TreeNode (TreeNode Nil 1 Nil) 6 (TreeNode Nil (-2) Nil))) 8 (TreeNode (TreeNode (TreeNode Nil 9 Nil) 5 (TreeNode Nil 4 Nil)) 4 (TreeNode (TreeNode Nil (-5) Nil) 14 (TreeNode Nil (-7) Nil)))
              let result6 = (TreeNode (TreeNode (TreeNode Nil 1 Nil) 3 (TreeNode Nil 6 Nil)) 4 (TreeNode (TreeNode Nil 5 Nil) 2 (TreeNode Nil 7 Nil)) + TreeNode (TreeNode (TreeNode Nil 1 Nil) 3 (TreeNode Nil 6 Nil)) 4 (TreeNode (TreeNode Nil 5 Nil) 2 (TreeNode Nil 7 Nil)) :: Tree Int) 
              result6 `shouldBe` TreeNode (TreeNode (TreeNode Nil 2 Nil) 6 (TreeNode Nil 12 Nil)) 8 (TreeNode (TreeNode Nil 10 Nil) 4 (TreeNode Nil 14 Nil))
  
  -- Test Longest Common String
      describe "longestCommonString" $ do
          it "should return the longest common string" $ do
              longestCommonString Null Null `shouldBe` Null
              longestCommonString (ListNode 'a' (ListNode 'b' (ListNode 'c' (ListNode 'd' (ListNode 'e' Null))))) Null `shouldBe` Null
              longestCommonString Null (ListNode 'a' (ListNode 'b' (ListNode 'c' (ListNode 'd' (ListNode 'e' Null))))) `shouldBe` Null
              longestCommonString (ListNode 'a' (ListNode 'b' (ListNode 'c' (ListNode 'd' (ListNode 'e' Null))))) (ListNode 'a' (ListNode 'b' (ListNode 'c' (ListNode 'd' (ListNode 'e' Null))))) `shouldBe` ListNode 'a' (ListNode 'b' (ListNode 'c' (ListNode 'd' (ListNode 'e' Null))))
              longestCommonString (ListNode 'a' (ListNode 'b' (ListNode 'c' (ListNode 'd' (ListNode 'e' Null))))) (ListNode 'a' (ListNode 'b' (ListNode 'c' (ListNode 'd' (ListNode 'f' Null))))) `shouldBe` ListNode 'a' (ListNode 'b' (ListNode 'c' (ListNode 'd' Null)))
              longestCommonString (ListNode 'a' (ListNode 'b' (ListNode 'c' (ListNode 'd' (ListNode 'e' Null))))) (ListNode 'a' (ListNode 'b' (ListNode 'c' (ListNode 'f' (ListNode 'e' Null))))) `shouldBe` ListNode 'a' (ListNode 'b' (ListNode 'c' Null))
              longestCommonString (ListNode 'a' (ListNode 'b' (ListNode 'c' (ListNode 'd' (ListNode 'e' Null))))) (ListNode 'a' (ListNode 'b' (ListNode 'f' (ListNode 'g' (ListNode 'e' Null))))) `shouldBe` ListNode 'a' (ListNode 'b' Null)
              longestCommonString (ListNode 'a' (ListNode 'b' (ListNode 'c' (ListNode 'd' (ListNode 'e' Null))))) (ListNode 'a' (ListNode 'f' (ListNode 'c' (ListNode 'd' (ListNode 'e' Null))))) `shouldBe` ListNode 'c' (ListNode 'd' (ListNode 'e' Null))
  
  -- Test Common Ancestor
      describe "commonAncestor" $ do
          it "should return the lowest common ancestor of the two nodes" $ do
              commonAncestor Nil 1 2 `shouldBe` Nothing
              commonAncestor (TreeNode (TreeNode Nil 1 Nil) 2 (TreeNode Nil 3 Nil)) 1 3 `shouldBe` Just 2
              commonAncestor (TreeNode (TreeNode Nil 1 Nil) 2 (TreeNode Nil 3 Nil)) 1 4 `shouldBe` Nothing
              commonAncestor (TreeNode (TreeNode (TreeNode Nil 1 Nil) 3 (TreeNode Nil 6 Nil)) 4 (TreeNode (TreeNode Nil 5 Nil) 2 (TreeNode Nil 7 Nil))) 1 7 `shouldBe` Just 4
              commonAncestor (TreeNode (TreeNode (TreeNode Nil 1 Nil) 3 (TreeNode Nil 6 Nil)) 4 (TreeNode (TreeNode Nil 5 Nil) 2 (TreeNode Nil 7 Nil))) 2 7 `shouldBe` Just 2
              commonAncestor (TreeNode (TreeNode (TreeNode Nil 1 Nil) 3 (TreeNode Nil 6 Nil)) 4 (TreeNode (TreeNode Nil 5 Nil) 2 (TreeNode Nil 7 Nil))) 1 3 `shouldBe` Just 3
  
  -- Test Game of Life
      describe "gameofLife" $ do
          it "should return the next state" $ do
              gameofLife [[0,1,0],[0,0,1],[1,1,1],[0,0,0]] `shouldBe` [[0,0,0],[1,0,1],[0,1,1],[0,1,0]]
              gameofLife [[1,1],[1,0]] `shouldBe` [[1,1],[1,1]]
              gameofLife [[1,1],[1,1]] `shouldBe` [[1,1],[1,1]]
              gameofLife [[1,0],[0,1]] `shouldBe` [[0,0],[0,0]]
              gameofLife [[0,1,0,0],[0,1,1,1],[1,0,1,1]] `shouldBe` [[0,1,0,0],[1,0,0, 1],[0,0,0,1]]
  
  -- Test Water Collection
      describe "waterCollection" $ do
          it "should return the amount of water that can be trapped" $ do
              waterCollection [0,1,0,2,1,0,1,3,2,1,2,1] `shouldBe` 12
              waterCollection [4,2,0,3,2,5] `shouldBe` 18
              waterCollection [1,2,3,4,5] `shouldBe` 0
              waterCollection [5,4,3,2,1] `shouldBe` 0
              waterCollection [5,4,3,2,1,2,3,4,5] `shouldBe` 32  
  
  -- Test Min Path Maze
      describe "minPathMaze" $ do
          it "should return the minimum cost to reach the bottom right cell" $ do
              minPathMaze [[1,3,1],[1,5,1],[4,2,1]] `shouldBe` 7
              minPathMaze [[1,2,3],[4,5,6]] `shouldBe` 12
              minPathMaze [[1,2,3],[4,5,6],[7,8,9]] `shouldBe` 21
              minPathMaze [[1,2,3,4],[4,5,6,7],[7,8,9,9],[10,11,1,13]] `shouldBe` 35
              minPathMaze [[1,2,3,4,5],[4,5,6,7,8],[7,8,9,9,10],[10,11,1,13,14],[15,16,17,18,19]] `shouldBe` 66
              minPathMaze [[1,2,3,4,5,6],[4,1,2,7,8,9],[7,8,1,2,10,11],[10,11,1,2,22,15],[15,16,17,1,2,20],[21,22,23,24,2,26]] `shouldBe` 41