module Utils exposing (getOrDefault, partition)

-- This function takes in a list and a partition size.  It splits
-- the list up into sub-lists of the partition size
-- NOTE: (List.length list) % size != 0, there remaining data will be left out
partition : List a -> Int -> List (List a)
partition list size =
    partitionHelper list size []

partitionHelper : List a -> Int -> List (List a) -> List (List a)
partitionHelper list size result =
    if (List.length list < 3) then
        result
    else
        let
            newList = List.drop size list
            newResult = result ++ [List.take size list]
        in
            partitionHelper newList size newResult

getOrDefault : List a -> Int -> a -> a
getOrDefault list index default =
    list
    |> List.drop index
    |> List.head
    |> Maybe.withDefault default