class A3_Static_F_Gamma_AT_01_AT_01_p3d : TRIPLES(ADDON,Cargo,Base)
{
    offset[] = {-0.5, 0.0, 1.05};
    rotation[] = {1, 0, 0};
    size = 2;
    recoil = 250;
    isWeapon = 1;
};
class A3_Static_F_Gamma_AA_01_AA_01_p3d : A3_Static_F_Gamma_AT_01_AT_01_p3d {};

class A3_Static_F_Gamma_GMG_01_GMG_01_high_F_p3d : TRIPLES(ADDON,Cargo,Base)
{
    offset[] = {0.2, -0.4, 1.7};
    rotation[] = {0, 1, 0};
    size = 2;
    recoil = 100;
    isWeapon = 1;
};
class A3_Static_F_Gamma_HMG_01_HMG_01_high_F_p3d: A3_Static_F_Gamma_GMG_01_GMG_01_high_F_p3d {};

class A3_Static_F_Gamma_GMG_01_GMG_01_F_p3d : TRIPLES(ADDON,Cargo,Base)
{
    offset[] = {0, 0, 1.19};
    rotation[] = {0, -1, 0};
    size = 4;
    recoil = 100;
    isWeapon = 1;
};
class A3_Static_F_Gamma_HMG_01_HMG_01_F_p3d : A3_Static_F_Gamma_GMG_01_GMG_01_F_p3d {};

class A3_static_f_Mortar_01_Mortar_01_F : TRIPLES(ADDON,Cargo,Base)
{
    offset[] = {-0.1,-0.5,0.79};
    rotation[] = {0, 1, 0};
    size = 2;
    recoil = 2000;
    isWeapon = 1;
    blackList[] = {"C_Boat_Civil_01_F", "B_Boat_Transport_01_F", "C_Boat_Transport_02_F"}; //todo convert to model
};

class A3_Static_F_HMG_02_HMG_02_high_F_p3d : TRIPLES(ADDON,Cargo,Base)
{
    offset[] = {-0.2, 0, 1.3};
    rotation[] = {0, -1, 0};
    size = 4;
    recoil = 100;
    isWeapon = 1;
};

class A3_Static_F_HMG_02_HMG_02_F_p3d : TRIPLES(ADDON,Cargo,Base)
{
    offset[] = {0.2, -0.5, 1.7};
    rotation[] = {0, 1, 0};
    size = 4;
    recoil = 100;
    isWeapon = 1;
};

class A3_Weapons_F_Ammoboxes_AmmoVeh_F : TRIPLES(ADDON,Cargo,Base)
{
    offset[] = {0,0,0.85};
    rotation[] = {1,0,0};
    size = 2;
};

class A3_Props_F_Orange_Humanitarian_Supplies_PaperBox_01_open_boxes_F_p3d : TRIPLES(ADDON,Cargo,Base)
{
    offset[] = {0,0,0.85};
    rotation[] = {1,0,0};
    size = 2;
};

class A3_Props_F_Orange_Humanitarian_Supplies_FoodSacks_01_cargonet_F_p3d : TRIPLES(ADDON,Cargo,Base)
{
    offset[] = {0,0,0.85};
    rotation[] = {1,0,0};
    size = 2;
};

class A3_Structures_F_Heli_Items_Luggage_PlasticCase_01_medium_F_p3d : TRIPLES(ADDON,Cargo,Base)
{
    offset[] = {0,0,0.85};
    rotation[] = {1,0,0};
    size = 2;
};

class A3_Weapons_F_Ammoboxes_Proxy_UsBasicAmmoBox_p3d : TRIPLES(ADDON,Cargo,Base)
{
    offset[] = {0,0,0.85};
    rotation[] = {1,0,0};
    size = 2;
};

class A3_Weapons_F_Ammoboxes_Proxy_UsBasicExplosives_p3d : TRIPLES(ADDON,Cargo,Base)
{
    offset[] = {0,0,0.85};
    rotation[] = {1,0,0};
    size = 2;
};

class A3_Weapons_F_Ammoboxes_Supplydrop_p3d : TRIPLES(ADDON,Cargo,Base)
{
    offset[] = {0, 0, 0.95};
    rotation[] = {1,0,0};
    size = 2;
};

class A3_Soft_F_Quadbike_01_Quadbike_01_F_p3d : TRIPLES(ADDON,Cargo,Base)
{
    offset[] = {0, 0, 1.4};
    rotation[] = {0,1,0};
    size = 2;
};

class A3_Supplies_F_Exp_Ammoboxes_Equipment_Box_F_p3d : TRIPLES(ADDON,Cargo,Base)
{
    offset[] = {0,0,0.44};
    rotation[] = {1,0,0};
};

class A3_weapons_F_AmmoBoxes_WpnsBox_F : TRIPLES(ADDON,Cargo,Base)
{
    offset[] = {0,0,0.22};
    rotation[] = {0,0,0};
};
