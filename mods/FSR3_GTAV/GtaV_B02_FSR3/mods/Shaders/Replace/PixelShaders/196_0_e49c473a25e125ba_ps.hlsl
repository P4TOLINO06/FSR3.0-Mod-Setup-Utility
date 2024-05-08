// ---- FNV Hash e49c473a25e125ba

// ---- Created with 3Dmigoto v1.3.16 on Sat Nov 11 18:21:54 2023

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

cbuffer lighting_locals : register(b12)
{
  float4 deferredLightParams[14] : packoffset(c0);
  float4 deferredLightVolumeParams[2] : packoffset(c14);
  float4 deferredLightScreenSize : packoffset(c16);
  float4 deferredProjectionParams : packoffset(c17);
  float3 deferredPerspectiveShearParams0 : packoffset(c18);
  float3 deferredPerspectiveShearParams1 : packoffset(c19);
  float3 deferredPerspectiveShearParams2 : packoffset(c20);
}

cbuffer vfx_fogvolume_locals : register(b11)
{
  float3 fogVolumeColor : packoffset(c0);
  float3 fogVolumePosition : packoffset(c1);
  float4 fogVolumeParams : packoffset(c2);
  row_major float4x4 fogVolumeTransform : packoffset(c3);
  row_major float4x4 fogVolumeInvTransform : packoffset(c7);
}

SamplerState fogVolumeDepthSampler_s : register(s5);
Texture2D<float4> fogVolumeDepthSampler : register(t5);


// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : TEXCOORD0,
  float4 v1 : TEXCOORD1,
  float4 v2 : TEXCOORD2,
  linear centroid float4 v3 : TEXCOORD3,
  float3 v4 : TEXCOORD4,
  float4 v5 : SV_Position0,
  float4 v6 : SV_ClipDistance0,
  float4 pos : POSITION0,
  out float4 o0 : SV_Target0,
  out float2 motionVectors : SV_Target4)
{

  float4 posCurr = mul(pos.xyzw, gWorldViewProjUnjittered);
  float4 posPrev = mul(pos.xyzw, gWorldViewProjUnjitteredPrev);
  posCurr.xy = posCurr.xy/posCurr.ww;
  posPrev.xy = posPrev.xy/posPrev.ww;
  motionVectors.xy = (posPrev.xy-posCurr.xy) * float2(0.5, -0.5);
  float4 r0,r1;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xy = v1.xy / v1.zz;
  r0.xyzw = fogVolumeDepthSampler.Sample(fogVolumeDepthSampler_s, r0.xy).xyzw;
  r0.y = 1 + deferredProjectionParams.w;
  r0.x = r0.y + -r0.x;
  r0.x = deferredProjectionParams.z / r0.x;
  r0.yzw = v3.xyz * r0.xxx + gViewInverse._m30_m31_m32;
  r1.xyz = v3.xyz * r0.xxx;
  r0.x = dot(r1.xyz, r1.xyz);
  r1.x = cmp(v2.w >= r0.x);
  r0.x = cmp(r0.x >= v2.z);
  r0.x = r0.x ? 1.000000 : 0;
  r1.yzw = v0.xyz * v2.yyy + gViewInverse._m30_m31_m32;
  r0.yzw = r1.xxx ? r0.yzw : r1.yzw;
  r1.xyz = v0.xyz * v2.xxx + gViewInverse._m30_m31_m32;
  r0.yzw = -r1.xyz + r0.yzw;
  r0.y = dot(r0.yzw, r0.yzw);
  r0.y = sqrt(r0.y);
  r0.y = -fogVolumeParams.x * r0.y;
  r0.y = 1.44269502 * r0.y;
  r0.y = exp2(r0.y);
  r0.y = min(1, r0.y);
  r0.y = 1 + -r0.y;
  r0.y = v3.w * r0.y;
  o0.w = r0.y * r0.x;
  o0.xyz = globalScalars3.zzz * v4.xyz;
  return;
}