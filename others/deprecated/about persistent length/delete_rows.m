function mats = delete_rows(mats, str_remain)
    keep_idx = contains(mats(:,2), str_remain);
    mats = mats(keep_idx,:);
end