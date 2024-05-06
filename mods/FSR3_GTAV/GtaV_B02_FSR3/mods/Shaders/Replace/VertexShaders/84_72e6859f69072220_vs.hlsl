// ---- FNV Hash 72e6859f69072220

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

cbuffer ped_common_locals2 : register(b10)
{
  float bumpiness : packoffset(c0);
  float specularFresnel : packoffset(c0.y);
  float specularFalloffMult : packoffset(c0.z);
  float specularIntensityMult : packoffset(c0.w);
  float orderNumber : packoffset(c1);
  float furMinLayers : packoffset(c1.y);
  float furMaxLayers : packoffset(c1.z);
  float furLength : packoffset(c1.w);
  float furNoiseUVScale : packoffset(c2);
  float furSelfShadowMin : packoffset(c2.y);
  float furStiffness : packoffset(c2.z);
  float furAOBlend : packoffset(c2.w);
  float3 furAttenCoef : packoffset(c3);
  float3 furGlobalParams : packoffset(c4);
  float4 furBendParams : packoffset(c5);
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
// unknown dcl_: dcl_input v6.xyzw
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v7.w
  float4 r0,r1,r2,r3,r4,r5,r6;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyzw = float4(255.001953,255.001953,255.001953,255.001953) * v2.xyzw;
  r0.xyzw = (int4)r0.xyzw;
  r0.xyzw = (int4)r0.xyzw * int4(3,3,3,3);
  r1.xyzw = gBoneMtx[r0.y/3]._m00_m01_m02_m03 * v1.yyyy;
  r1.xyzw = gBoneMtx[r0.x/3]._m00_m01_m02_m03 * v1.xxxx + r1.xyzw;
  r1.xyzw = gBoneMtx[r0.z/3]._m00_m01_m02_m03 * v1.zzzz + r1.xyzw;
  r1.xyzw = gBoneMtx[r0.w/3]._m00_m01_m02_m03 * v1.wwww + r1.xyzw;
  r2.x = dot(r1.xyz, v4.xyz);
  r3.xyzw = gBoneMtx[r0.y/3]._m10_m11_m12_m13 * v1.yyyy;
  r3.xyzw = gBoneMtx[r0.x/3]._m10_m11_m12_m13 * v1.xxxx + r3.xyzw;
  r3.xyzw = gBoneMtx[r0.z/3]._m10_m11_m12_m13 * v1.zzzz + r3.xyzw;
  r3.xyzw = gBoneMtx[r0.w/3]._m10_m11_m12_m13 * v1.wwww + r3.xyzw;
  r2.y = dot(r3.xyz, v4.xyz);
  r4.xyzw = gBoneMtx[r0.y/3]._m20_m21_m22_m23 * v1.yyyy;
  r4.xyzw = gBoneMtx[r0.x/3]._m20_m21_m22_m23 * v1.xxxx + r4.xyzw;
  r4.xyzw = gBoneMtx[r0.z/3]._m20_m21_m22_m23 * v1.zzzz + r4.xyzw;
  r0.xyzw = gBoneMtx[r0.w/3]._m20_m21_m22_m23 * v1.wwww + r4.xyzw;
  r2.z = dot(r0.xyz, v4.xyz);
  r4.xyz = furBendParams.xyz + -r2.xyz;
  r4.xyz = furBendParams.www * r4.xyz + r2.xyz;
  r5.xyz = gWorld._m10_m11_m12 * r2.yyy;
  r2.xyw = r2.xxx * gWorld._m00_m01_m02 + r5.xyz;
  r2.xyz = r2.zzz * gWorld._m20_m21_m22 + r2.xyw;
  r4.xyz = furGlobalParams.xxx * r4.xyz;
  r5.xyz = v0.xyz;
  r5.w = 1;
  r6.x = dot(r1.xyzw, r5.xyzw);
  r1.x = dot(r1.xyz, v5.xyz);
  r6.y = dot(r3.xyzw, r5.xyzw);
  r1.y = dot(r3.xyz, v5.xyz);
  r1.yzw = gWorld._m10_m11_m12 * r1.yyy;
  r1.xyz = r1.xxx * gWorld._m00_m01_m02 + r1.yzw;
  r6.z = dot(r0.xyzw, r5.xyzw);
  r0.x = dot(r0.xyz, v5.xyz);
  r0.xyz = r0.xxx * gWorld._m20_m21_m22 + r1.xyz;
  r1.xyz = r4.xyz * v7.www + r6.xyz;
  r3.xyz = gWorld._m10_m11_m12 * r6.yyy;
  r3.xyz = r6.xxx * gWorld._m00_m01_m02 + r3.xyz;
  r3.xyz = r6.zzz * gWorld._m20_m21_m22 + r3.xyz;
  r3.xyz = gWorld._m30_m31_m32 + r3.xyz;
  o4.xyz = gViewInverse._m30_m31_m32 + -r3.xyz;
  pos.xyzw = float4(r1.xyz, 1);
  r3.xyzw = gWorldViewProj._m10_m11_m12_m13 * r1.yyyy;
  r3.xyzw = r1.xxxx * gWorldViewProj._m00_m01_m02_m03 + r3.xyzw;
  r1.xyzw = r1.zzzz * gWorldViewProj._m20_m21_m22_m23 + r3.xyzw;
  o0.xyzw = gWorldViewProj._m30_m31_m32_m33 + r1.xyzw;
  r0.w = saturate(-v7.w * 1.07374182e+09 + 1);
  o1.w = saturate(furGlobalParams.z + r0.w);
  o1.xy = v3.xy;
  o1.z = furGlobalParams.y;
  o2.xyz = r2.xyz;
  o3.xyzw = v6.xyzw;
  o5.xyz = r0.xyz;
  r1.xyz = r0.zxy * r2.yzx;
  r0.xyz = r0.yzx * r2.zxy + -r1.xyz;
  o6.xyz = v5.www * r0.xyz;
  o7.y = -v6.y * 25.5 + 1;
  r0.xy = float2(0.529411793,-0.0392156877) + v6.yy;
  r0.z = r0.x * r0.x;
  o7.z = r0.z * r0.x;
  r0.x = globalScalars2.w * r0.y;
  o7.x = 0.960784316 * r0.x;
  return;
}