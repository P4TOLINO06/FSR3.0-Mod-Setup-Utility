// ---- FNV Hash 992cdd2c9e646853

// ---- Created with 3Dmigoto v1.3.16 on Sat Nov  4 12:47:49 2023

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
  float4 v1 : COLOR0,
  float4 v2 : COLOR1,
  float4 v3 : TEXCOORD0,
  float2 v4 : TEXCOORD1,
  float3 v5 : NORMAL0,
  float4 v6 : TANGENT0,
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

  pos.xyzw = float4(v0.xyz, 1);
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
  float4 r0,r1,r2,r3;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyz = gWorld._m10_m11_m12 * v0.yyy;
  r0.xyz = v0.xxx * gWorld._m00_m01_m02 + r0.xyz;
  r0.xyz = v0.zzz * gWorld._m20_m21_m22 + r0.xyz;
  r0.xyz = gWorld._m30_m31_m32 + r0.xyz;
  o4.xyz = gViewInverse._m30_m31_m32 + -r0.xyz;
  r0.xyz = gWorld._m10_m11_m12 * v5.yyy;
  r0.xyz = v5.xxx * gWorld._m00_m01_m02 + r0.xyz;
  r0.xyz = v5.zzz * gWorld._m20_m21_m22 + r0.xyz;
  r1.xyz = gWorld._m10_m11_m12 * v6.yyy;
  r1.xyz = v6.xxx * gWorld._m00_m01_m02 + r1.xyz;
  r1.xyz = v6.zzz * gWorld._m20_m21_m22 + r1.xyz;
  r2.xyz = r1.zxy * r0.yzx;
  r2.xyz = r1.yzx * r0.zxy + -r2.xyz;
  o6.xyz = v6.www * r2.xyz;
  r2.xyz = umGlobalParams.xxy * v2.xxz;
  r2.xyz = umPedGlobalOverrideParams.xxy * r2.xyz;
  r1.w = 6.28318501 * v2.y;
  r3.xyz = umGlobalParams.zzw * umPedGlobalOverrideParams.zzw;
  r3.xyz = globalScalars2.xxx * r3.xyz + r1.www;
  r3.xyz = sin(r3.xyz);
  r2.xyz = r3.xyz * r2.xyz + v0.xyz;
  r3.xyzw = gWorldViewProj._m10_m11_m12_m13 * r2.yyyy;
  r3.xyzw = r2.xxxx * gWorldViewProj._m00_m01_m02_m03 + r3.xyzw;
  r2.xyzw = r2.zzzz * gWorldViewProj._m20_m21_m22_m23 + r3.xyzw;
  o0.xyzw = gWorldViewProj._m30_m31_m32_m33 + r2.xyzw;
  r1.w = cmp(v4.x != 0.000000);
  if (r1.w != 0) {
    r1.w = 0.5 + -v4.y;
    r1.w = 0.5 * r1.w;
    r1.w = (int)r1.w;
    r2.x = cmp((int)r1.w >= 2);
    r3.xyzw = v4.yxxy * float4(-1,1,1,-1) + float4(1,0,0,1);
    o7.xy = r2.xx ? r3.xy : r3.zw;
    r2.x = frac(PedDamageData.w);
    r2.yz = r2.xx * float2(-0.800000012,0.600000024) + icb[r1.w+0].xy;
    r2.x = PedDamageData.w + -r2.x;
    r2.x = 1 / r2.x;
    r3.xy = r2.xx * float2(0.600000024,-0.800000012) + icb[r1.w+0].yx;
    o7.zw = icb[r1.w+0].zw * r2.yz;
    r0.w = r3.x;
  } else {
    o7.xyzw = float4(0,0,0,0);
    r3.y = 0;
    r0.w = 0;
  }
  r1.w = cmp(matWetClothesData.w < 0);
  r1.w = r1.w ? 0 : v0.z;
  r2.xy = -matWetClothesData.xy + r1.ww;
  r2.xy = saturate(r2.xy / wetnessAdjust.ww);
  r1.w = matWetClothesData.w + -matWetClothesData.z;
  r1.w = r2.x * r1.w + matWetClothesData.z;
  r2.x = 1 + -r2.y;
  r1.w = r2.x * r1.w;
  r2.x = envEffFatSweatScale.w * v2.w;
  r3.x = max(r2.x, abs(r1.w));
  r2.xy = float2(0.529411793,-0.0392156877) + v1.yy;
  r1.w = globalScalars2.w * r2.y;
  o8.x = 0.960784316 * r1.w;
  o8.y = -v1.y * 25.5 + 1;
  r1.w = r2.x * r2.x;
  o8.z = r1.w * r2.x;
  r3.zw = v3.xy;
  o1.xyzw = r3.zwxy;
  o2.xyzw = r0.xyzw;
  o3.xyzw = v1.xyzw;
  o5.xyz = r1.xyz;
  return;
}