// ---- FNV Hash 1b0f63ab029f04e3

// ---- Created with 3Dmigoto v1.3.16 on Thu Nov  9 22:12:47 2023

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

cbuffer scaleform_shaders_locals : register(b11)
{
  float4 UIPosMtx[2] : packoffset(c0);
  float4 UITex0Mtx[2] : packoffset(c2);
  float4 UITex1Mtx[2] : packoffset(c4);
  float4 UIColor : packoffset(c6);
  float4 UIColorXformOffset : packoffset(c7);
  float4 UIColorXformScale : packoffset(c8);
  float UIPremultiplyAlpha : packoffset(c9);
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

SamplerState UITexture0_s : register(s2);
Texture2D<float4> UITexture0 : register(t2);


// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_Position0,
  float4 v1 : COLOR0,
  float4 v2 : COLOR1,
  float2 v3 : TEXCOORD0,
  float4 pos : POSITION0,
  out float4 o0 : SV_Target0,
  out float2 motionVectors : SV_Target4)
{

  float4 posCurr = mul(pos.xyzw, gWorldViewProjUnjittered);
  float4 posPrev = mul(pos.xyzw, gWorldViewProjUnjitteredPrev);
  posCurr.xy = posCurr.xy/posCurr.ww;
  posPrev.xy = posPrev.xy/posPrev.ww;
  motionVectors.xy = (posPrev.xy-posCurr.xy) * float2(0.5, -0.5);
  float4 r0,r1,r2;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.x = cmp(UIPremultiplyAlpha == 0.000000);
  r1.xyzw = UITexture0.Sample(UITexture0_s, v3.xy).xyzw;
  r1.xyzw = r1.xyzw * UIColorXformScale.xyzw + UIColorXformOffset.xyzw;
  r0.y = v2.w * r1.w;
  r2.xyz = r1.xyz * r0.yyy;
  r0.xzw = r0.xxx ? r1.xyz : r2.xyz;
  r1.xy = globalScalars.wx * r0.yy;
  r0.y = cmp(globalScalars.w != 1.000000);
  r1.x = r1.x * r1.x;
  o0.w = saturate(r1.y);
  o0.z = r0.y ? r1.x : r0.w;
  o0.xy = r0.xz;
  return;
}