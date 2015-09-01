function result = diceTrials(n)
    if(n>0)
        result = uint8(rand([1,n])*5)+1;
    else
        result = 'You may wanna not to do that operation, the number of trials must be greater than 0';
        error(result)
end