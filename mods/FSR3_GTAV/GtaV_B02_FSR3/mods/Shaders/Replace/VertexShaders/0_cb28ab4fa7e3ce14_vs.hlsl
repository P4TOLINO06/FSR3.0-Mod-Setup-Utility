// ---- FNV Hash cb28ab4fa7e3ce14

// ---- Created with 3Dmigoto v1.3.16 on Sat Nov  4 12:47:49 2023

cbuffer rage_bonemtx : register(b4)
{
  row_major float3x4 gBoneMtx[255] : packoffset(c0);
}

cbuffer rage_matrices : register(b1)
{
  row_major float4x4 gWorld : packoffset(c0);
  row_major float4x4 gWorldView : packoffset(c4);
  row_major float4x4 gWorldViewProj : packoffset(c8);
  row_major float4x4 gViewInverse : packoffset(c12);
  row_major float4x4 gWorldViewProjUnjittered : packoffset(c16);
  row_major float4x4 gWorldViewProjUnjitteredPrev : packoffset(c20);
}

cbuffer misc_globals : register(b2)
{
  float4 globalFade : packoffset(c0);
  float globalHeightScale : packoffset(c1);
  float globalShaderQuality : packoffset(c1.y);
  float globalReuseMe00001 : packoffset(c1.z);
  float globalReuseMe00002 : packoffset(c1.w);
  float4 POMFlags : packoffset(c2);
  float4 g_Rage_Tessellation_CameraPosition : packoffset(c3);
  float4 g_Rage_Tessellation_CameraZAxis : packoffset(c4);
  float4 g_Rage_Tessellation_ScreenSpaceErrorParams : packoffset(c5);
  float4 g_Rage_Tessellation_LinearScale : packoffset(c6);
  float4 g_Rage_Tessellation_Frustum[4] : packoffset(c7);
  float4 g_Rage_Tessellation_Epsilons : packoffset(c11);
  float4 globalScalars : packoffset(c12);
  float4 globalScalars2 : packoffset(c13);
  float4 globalScalars3 : packoffset(c14);
  float4 globalScreenSize : packoffset(c15);
  uint4 gTargetAAParams : packoffset(c16);
  float4 colorize : packoffset(c17);
  float4 gGlobalParticleShadowBias : packoffset(c18);
  float gGlobalParticleDofAlphaScale : packoffset(c19);
  float gGlobalFogIntensity : packoffset(c19.y);
  float4 gPlayerLFootPos : packoffset(c20);
  float4 gPlayerRFootPos : packoffset(c21);
}

cbuffer ped_common_shared_locals : register(b13)
{
  float4 matWetClothesData : packoffset(c0);
  float4 umPedGlobalOverrideParams : packoffset(c1);
  float4 envEffFatSweatScale : packoffset(c2);
  float paletteSelector : packoffset(c3);
  float2 StubbleGrowth : packoffset(c3.y);
  float4 _matMaterialColorScale[2] : packoffset(c4);
  float4 PedDamageColors[3] : packoffset(c6);
  float4 envEffColorModCpvAdd : packoffset(c9);
  float4 wrinkleMaskStrengths0 : packoffset(c10);
  float4 wrinkleMaskStrengths1 : packoffset(c11);
  float4 wrinkleMaskStrengths2 : packoffset(c12);
  float4 wrinkleMaskStrengths3 : packoffset(c13);
  float4 wrinkleMaskStrengths4 : packoffset(c14);
  float4 wrinkleMaskStrengths5 : packoffset(c15);
  float4 PedDamageData : packoffset(c16);
  float4 wetnessAdjust : packoffset(c17);
  float alphaToCoverageScale : packoffset(c18);
}

cbuffer pedmisclocals : register(b8)
{
  float4 umGlobalParams : packoffset(c0);
}



// 3Dmigoto declarations
#define cmp -


void main(
  float3 v0 : POSITION0,
  float4 v1 : BLENDWEIGHT0,
  float4 v2 : BLENDINDICES0,
  float4 v3 : TEXCOORD0,
  float2 v4 : TEXCOORD1,
  float3 v5 : NORMAL0,
  float4 v6 : TANGENT0,
  float4 v7 : COLOR0,
  float4 v8 : COLOR1,
  uint v9 : SV_InstanceID0,
  out float4 o0 : SV_Position0,
  out float4 o1 : TEXCOORD0,
  out float4 o2 : TEXCOORD1,
  out float4 o3 : TEXCOORD3,
  out float4 o4 : TEXCOORD4,
  out float4 o5 : TEXCOORD5,
  out float4 o6 : TEXCOORD6,
  out float4 o7 : TEXCOORD7,
  out float3 o8 : TEXCOORD2,
  out float4 pos : POSITION0)
{
  const float4 icb[] = { { 0.400000, 0, 1.000000, 1.000000},
                              { 0.200000, 0.400000, 1.000000, 1.000000},
                              { 0.100000, 0.600000, -1.000000, 1.000000},
                              { 0.100000, 0.700000, 1.000000, -1.000000},
                              { 0.100000, 0.800000, 1.000000, 1.000000},
                              { 0.100000, 0.900000, 1.000000, 1.000000} };
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v0.xyz
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v1.xyzw
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v2.xyzw
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v3.xy
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v4.xy
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v5.xyz
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v6.xyzw
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v7.xyz
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v8.xyzw
  float4 r0,r1,r2,r3,r4;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyzw = float4(255.001953,255.001953,255.001953,255.001953) * v2.xyzw;
  r0.xyzw = (int4)r0.xyzw;
  r0.xyzw = (int4)r0.xyzw * int4(3,3,3,3);
  r1.xyzw = gBoneMtx[r0.y/3]._m00_m01_m02_m03 * v1.yyyy;
  r2.xyzw = gBoneMtx[r0.y/3]._m10_m11_m12_m13 * v1.yyyy;
  r3.xyzw = gBoneMtx[r0.y/3]._m20_m21_m22_m23 * v1.yyyy;
  r1.xyzw = gBoneMtx[r0.x/3]._m00_m01_m02_m03 * v1.xxxx + r1.xyzw;
  r2.xyzw = gBoneMtx[r0.x/3]._m10_m11_m12_m13 * v1.xxxx + r2.xyzw;
  r3.xyzw = gBoneMtx[r0.x/3]._m20_m21_m22_m23 * v1.xxxx + r3.xyzw;
  r1.xyzw = gBoneMtx[r0.z/3]._m00_m01_m02_m03 * v1.zzzz + r1.xyzw;
  r2.xyzw = gBoneMtx[r0.z/3]._m10_m11_m12_m13 * v1.zzzz + r2.xyzw;
  r3.xyzw = gBoneMtx[r0.z/3]._m20_m21_m22_m23 * v1.zzzz + r3.xyzw;
  r1.xyzw = gBoneMtx[r0.w/3]._m00_m01_m02_m03 * v1.wwww + r1.xyzw;
  r2.xyzw = gBoneMtx[r0.w/3]._m10_m11_m12_m13 * v1.wwww + r2.xyzw;
  r0.xyzw = gBoneMtx[r0.w/3]._m20_m21_m22_m23 * v1.wwww + r3.xyzw;
  r3.xyz = v0.xyz;
  r3.w = 1;
  r4.x = dot(r1.xyzw, r3.xyzw);
  r4.y = dot(r2.xyzw, r3.xyzw);
  r4.z = dot(r0.xyzw, r3.xyzw);
  r3.xyz = gWorld._m10_m11_m12 * r4.yyy;
  r3.xyz = r4.xxx * gWorld._m00_m01_m02 + r3.xyz;
  r3.xyz = r4.zzz * gWorld._m20_m21_m22 + r3.xyz;
  r3.xyz = gWorld._m30_m31_m32 + r3.xyz;
  o4.xyz = gViewInverse._m30_m31_m32 + -r3.xyz;
  r0.w = dot(r1.xyz, v5.xyz);
  r1.w = dot(r2.xyz, v5.xyz);
  r2.w = dot(r0.xyz, v5.xyz);
  r3.xyz = gWorld._m10_m11_m12 * r1.www;
  r3.xyz = r0.www * gWorld._m00_m01_m02 + r3.xyz;
  r3.xyz = r2.www * gWorld._m20_m21_m22 + r3.xyz;
  r0.w = dot(r1.xyz, v6.xyz);
  r1.x = dot(r2.xyz, v6.xyz);
  r0.x = dot(r0.xyz, v6.xyz);
  r1.xyz = gWorld._m10_m11_m12 * r1.xxx;
  r0.yzw = r0.www * gWorld._m00_m01_m02 + r1.xyz;
  r0.xyz = r0.xxx * gWorld._m20_m21_m22 + r0.yzw;
  r1.xyz = r0.zxy * r3.yzx;
  r1.xyz = r0.yzx * r3.zxy + -r1.xyz;
  o6.xyz = v6.www * r1.xyz;
  r1.xyz = umGlobalParams.xxy * v8.xxz;
  r1.xyz = umPedGlobalOverrideParams.xxy * r1.xyz;
  r0.w = 6.28318501 * v8.y;
  r2.xyz = umGlobalParams.zzw * umPedGlobalOverrideParams.zzw;
  r2.xyz = globalScalars2.xxx * r2.xyz + r0.www;
  r2.xyz = sin(r2.xyz);
  r1.xyz = r2.xyz * r1.xyz + r4.xyz;
  r2.xy = float2(0.529411793,-0.0392156877) + v7.yy;
  r0.w = globalScalars2.w * r2.y;
  o8.x = 0.960784316 * r0.w;
  o8.y = -v7.y * 25.5 + 1;
  r0.w = r2.x * r2.x;
  o8.z = r0.w * r2.x;
  pos.xyzw = float4(r1.xyz, 1);
  r2.xyzw = gWorldViewProj._m10_m11_m12_m13 * r1.yyyy;
  r2.xyzw = r1.xxxx * gWorldViewProj._m00_m01_m02_m03 + r2.xyzw;
  r1.xyzw = r1.zzzz * gWorldViewProj._m20_m21_m22_m23 + r2.xyzw;
  o0.xyzw = gWorldViewProj._m30_m31_m32_m33 + r1.xyzw;
  r0.w = cmp(v4.x != 0.000000);
  if (r0.w != 0) {
    r0.w = 0.5 + -v4.y;
    r0.w = 0.5 * r0.w;
    r0.w = (int)r0.w;
    r1.x = cmp((int)r0.w >= 2);
    r2.xyzw = v4.yxxy * float4(-1,1,1,-1) + float4(1,0,0,1);
    o7.xy = r1.xx ? r2.xy : r2.zw;
    r1.x = frac(PedDamageData.w);
    r1.yz = r1.xx * float2(-0.800000012,0.600000024) + icb[r0.w+0].xy;
    r1.x = PedDamageData.w + -r1.x;
    r1.x = 1 / r1.x;
    r2.xy = r1.xx * float2(0.600000024,-0.800000012) + icb[r0.w+0].yx;
    o7.zw = icb[r0.w+0].zw * r1.yz;
    r3.w = r2.x;
  } else {
    o7.xyzw = float4(0,0,0,0);
    r2.y = 0;
    r3.w = 0;
  }
  r0.w = cmp(matWetClothesData.w < 0);
  r0.w = r0.w ? 0 : v0.z;
  r1.xy = -matWetClothesData.xy + r0.ww;
  r1.xy = saturate(r1.xy / wetnessAdjust.ww);
  r0.w = matWetClothesData.w + -matWetClothesData.z;
  r0.w = r1.x * r0.w + matWetClothesData.z;
  r1.x = 1 + -r1.y;
  r0.w = r1.x * r0.w;
  r1.x = envEffFatSweatScale.w * v8.w;
  r2.x = max(r1.x, abs(r0.w));
  r2.zw = v3.xy;
  o1.xyzw = r2.zwxy;
  o2.xyzw = r3.xyzw;
  o3.xyz = v7.xyz;
  o3.w = 1;
  o5.xyz = r0.xyz;
  return;
}