class DOUBLES(ADDON,Nodes)
{
    class TRIPLES(ADDON,Nodes,Base)
    {
        class Nodes {};
        canLoadWeapon = 1; //if the vehicle can load weapons
    };

    #include "Nodes\vanilla.hpp"
    #include "Nodes\rhs.hpp"
    #include "Nodes\3cb.hpp"
    #include "Nodes\vn.hpp"
    #include "Nodes\ffaa.hpp"
};

class DOUBLES(ADDON,Cargo)
{
    class TRIPLES(ADDON,Cargo,Base)
    {
        offset[] = {0,0,0}; //the offset from the node(s) to load the cargo on too
        rotation[] = {0,1,0}; //the rotation from the vehicle model front
        size = 1; //the amount of nodes it occupies
        recoil = 0; //the recoil a weapon impacts on the vehicle when fired (per projectile)
        isWeapon = 0; //if the cargo is a weapon (needed for proper handling of mounted weapon)
        blackList[] = {}; //specific vehicles or models to blacklist from loading this weapon/cargo
    };

    #include "Cargo\Vanilla.hpp"
    #include "Cargo\rhs.hpp"
    #include "Cargo\3cb.hpp"
    #include "Cargo\vn.hpp"
};
