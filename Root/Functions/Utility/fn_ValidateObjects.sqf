_this apply {
    if (isNil _x) then {
        objNull
    } else {
        call compile _x
    };
};
