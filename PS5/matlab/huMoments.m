function moments = huMoments(H)
    [h,w] = size(H);
    
    rows = [1:h]';
    cols = [1:w];
    rows = rows - mean(rows);
    cols = cols - mean(cols);
    
    rows_0 = 1;
    rows_1 = rows;
    rows_2 = rows.^2;
    rows_3 = rows.^3;
    
    cols_0 = 1;
    cols_1 = cols;
    cols_2 = cols .^2;
    cols_3 = cols .^3;
    
    
    mu_02 = sum(sum(bsxfun(@times,(rows_2 * cols_0 ),H)));
    mu_03 = sum(sum(bsxfun(@times,(rows_3 * cols_0 ),H)));
    mu_11 = sum(sum((rows_1 * cols_1 ).*H));
    mu_12 = sum(sum((rows_1 * cols_1).*H));
    mu_20 = sum(sum(bsxfun(@times,(rows_0 * cols_2),H)));
    mu_21 = sum(sum((rows_1 * cols_2).*H));
    mu_30 = sum(sum(bsxfun(@times,(rows_0 * cols_3 ),H)));
    
    h1 = mu_20 + mu_02;
    h2 = (mu_20 - mu_02)^2 + 4*mu_11;
    h3 = (mu_30 - 3*mu_12)^2 +(3*mu_21 - mu_03)^2;
    h4 = (mu_30 + mu_12)^2 + (mu_21 + mu_03)^2;
    h5 = (mu_30 - 3*mu_12)*(mu_30+mu_12)* ((mu_30+mu_12)^2-3*(mu_21+mu_03)^2)...
        + (3*mu_21-mu_12)*(mu_21+mu_03)...
        * (3*(mu_30+mu_12)^2-(mu_21+mu_03)^2);
    h6 = (mu_20-mu_02)*((mu_30+mu_12)^2-(mu_21+mu_03)^2)...
        +4*mu_11*(mu_30+mu_12)*(mu_21+mu_03);
    h7 = (3*mu_21-mu_03)*(mu_30+mu_12)*((mu_30+mu_12)^2-3*(mu_21+mu_03)^2)...
        -(mu_30-3*mu_12)*(mu_21+mu_03)*(3*(mu_30+mu_12)^2-(mu_21+mu_03)^2);
    
    moments = [h1,h2,h3,h4,h5,h6,h7];
end

