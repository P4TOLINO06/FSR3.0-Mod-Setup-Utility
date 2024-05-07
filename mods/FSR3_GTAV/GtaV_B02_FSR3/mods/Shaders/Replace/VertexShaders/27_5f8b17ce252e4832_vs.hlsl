// ---- FNV Hash 5f8b17ce252e4832

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
  float AnisotropicAlphaBias : packoffset(c0);
  float4 umGlobalParams : packoffset(c1);
}



// 3Dmigoto declarations
#define cmp -


void main(
  float3 v0 : POSITION0,
  float4 v1 : BLENDWEIGHT0,
  float4 v2 : BLENDINDICES0,
  float2 v3 : TEXCOORD0,
  float3 v4 : NORMAL0,
  float4 v5 : TANGENT0,
  float4 v6 : COLOR0,
  float4 v7 : COLOR1,
  uint v8 : SV_InstanceID0,
  out float4 o0 : SV_Position0,
  out float4 o1 : TEXCOORD0,
  out float4 o2 : TEXCOORD1,
  out float4 o3 : TEXCOORD3,
  out float4 o4 : TEXCOORD4,
  out float4 o5 : TEXCOORD5,
  out float4 o6 : TEXCOORD6,
  out float3 o7 : TEXCOORD2,
  out float4 pos : POSITION0)
{
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v0.xyz
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v1.xyzw
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v2.xyzw
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v3.xy
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v4.xyz
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v5.xyzw
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v6.xyz
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v7.xyzw
  float4 r0,r1,r2,r3,r4,r5,r6,r7;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.x = 6.28318501 * v7.y;
  r0.yzw = umGlobalParams.zzw * umPedGlobalOverrideParams.zzw;
  r0.xyz = globalScalars2.xxx * r0.yzw + r0.xxx;
  r0.xyz = sin(r0.xyz);
  r1.xyz = umGlobalParams.xxy * v7.xxz;
  r1.xyz = umPedGlobalOverrideParams.xxy * r1.xyz;
  r2.xyzw = float4(255.001953,255.001953,255.001953,255.001953) * v2.xyzw;
  r2.xyzw = (int4)r2.xyzw;
  r2.xyzw = (int4)r2.xyzw * int4(3,3,3,3);
  r3.xyzw = gBoneMtx[r2.y/3]._m00_m01_m02_m03 * v1.yyyy;
  r3.xyzw = gBoneMtx[r2.x/3]._m00_m01_m02_m03 * v1.xxxx + r3.xyzw;
  r3.xyzw = gBoneMtx[r2.z/3]._m00_m01_m02_m03 * v1.zzzz + r3.xyzw;
  r3.xyzw = gBoneMtx[r2.w/3]._m00_m01_m02_m03 * v1.wwww + r3.xyzw;
  r4.xyz = v0.xyz;
  r4.w = 1;
  r5.x = dot(r3.xyzw, r4.xyzw);
  r6.xyzw = gBoneMtx[r2.y/3]._m10_m11_m12_m13 * v1.yyyy;
  r6.xyzw = gBoneMtx[r2.x/3]._m10_m11_m12_m13 * v1.xxxx + r6.xyzw;
  r6.xyzw = gBoneMtx[r2.z/3]._m10_m11_m12_m13 * v1.zzzz + r6.xyzw;
  r6.xyzw = gBoneMtx[r2.w/3]._m10_m11_m12_m13 * v1.wwww + r6.xyzw;
  r5.y = dot(r6.xyzw, r4.xyzw);
  r7.xyzw = gBoneMtx[r2.y/3]._m20_m21_m22_m23 * v1.yyyy;
  r7.xyzw = gBoneMtx[r2.x/3]._m20_m21_m22_m23 * v1.xxxx + r7.xyzw;
  r7.xyzw = gBoneMtx[r2.z/3]._m20_m21_m22_m23 * v1.zzzz + r7.xyzw;
  r2.xyzw = gBoneMtx[r2.w/3]._m20_m21_m22_m23 * v1.wwww + r7.xyzw;
  r5.z = dot(r2.xyzw, r4.xyzw);
  r0.xyz = r0.xyz * r1.xyz + r5.xyz;
  r1.xyz = gWorld._m10_m11_m12 * r5.yyy;
  r1.xyz = r5.xxx * gWorld._m00_m01_m02 + r1.xyz;
  r1.xyz = r5.zzz * gWorld._m20_m21_m22 + r1.xyz;
  r1.xyz = gWorld._m30_m31_m32 + r1.xyz;
  o4.xyz = gViewInverse._m30_m31_m32 + -r1.xyz;
  pos.xyzw = float4(r0.xyz, 1);
  r1.xyzw = gWorldViewProj._m10_m11_m12_m13 * r0.yyyy;
  r1.xyzw = r0.xxxx * gWorldViewProj._m00_m01_m02_m03 + r1.xyzw;
  r0.xyzw = r0.zzzz * gWorldViewProj._m20_m21_m22_m23 + r1.xyzw;
  o0.xyzw = gWorldViewProj._m30_m31_m32_m33 + r0.xyzw;
  r0.x = cmp(matWetClothesData.w < 0);
  r0.x = r0.x ? 0 : v0.z;
  r0.xy = -matWetClothesData.xy + r0.xx;
  r0.xy = saturate(r0.xy / wetnessAdjust.ww);
  r0.z = matWetClothesData.w + -matWetClothesData.z;
  r0.x = r0.x * r0.z + matWetClothesData.z;
  r0.y = 1 + -r0.y;
  r0.x = r0.x * r0.y;
  r0.y = envEffFatSweatScale.w * v7.w;
  o1.z = max(abs(r0.x), r0.y);
  o1.xy = v3.xy;
  r0.x = dot(r6.xyz, v4.xyz);
  r0.y = dot(r6.xyz, v5.xyz);
  r0.yzw = gWorld._m10_m11_m12 * r0.yyy;
  r1.xyz = gWorld._m10_m11_m12 * r0.xxx;
  r0.x = dot(r3.xyz, v4.xyz);
  r1.w = dot(r3.xyz, v5.xyz);
  r0.yzw = r1.www * gWorld._m00_m01_m02 + r0.yzw;
  r1.xyz = r0.xxx * gWorld._m00_m01_m02 + r1.xyz;
  r0.x = dot(r2.xyz, v4.xyz);
  r1.w = dot(r2.xyz, v5.xyz);
  r0.yzw = r1.www * gWorld._m20_m21_m22 + r0.yzw;
  r1.xyz = r0.xxx * gWorld._m20_m21_m22 + r1.xyz;
  o2.xyz = r1.xyz;
  o3.xyz = v6.xyz;
  o3.w = 1;
  o5.xyz = r0.yzw;
  r2.xyz = r1.yzx * r0.wyz;
  r0.xyz = r0.zwy * r1.zxy + -r2.xyz;
  o6.xyz = v5.www * r0.xyz;
  o7.y = -v6.y * 25.5 + 1;
  r0.xy = float2(0.529411793,-0.0392156877) + v6.yy;
  r0.z = r0.x * r0.x;
  o7.z = r0.z * r0.x;
  r0.x = globalScalars2.w * r0.y;
  o7.x = 0.960784316 * r0.x;
  return;
}