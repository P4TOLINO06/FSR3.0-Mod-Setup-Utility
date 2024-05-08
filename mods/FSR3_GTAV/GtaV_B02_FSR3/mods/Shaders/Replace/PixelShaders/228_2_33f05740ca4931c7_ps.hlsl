// ---- FNV Hash 33f05740ca4931c7

// ---- Created with 3Dmigoto v1.3.16 on Mon Nov 13 01:20:59 2023

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

cbuffer ssao_locals : register(b12)
{
  float4 g_projParams : packoffset(c0);
  float4 gNormalOffset : packoffset(c1);
  float4 gOffsetScale0 : packoffset(c2);
  float4 gOffsetScale1 : packoffset(c3);
  float g_SSAOStrength : packoffset(c4);
  float4 g_CPQSMix_QSFadeIn : packoffset(c5);
  float4 TargetSizeParam : packoffset(c6);
  float4 FallOffAndKernelParam : packoffset(c7);
  float4 g_MSAAPointTexture1_Dim : packoffset(c8);
  float4 g_MSAAPointTexture2_Dim : packoffset(c9);
  float4 gExtraParams0 : packoffset(c10);
  float4 gExtraParams1 : packoffset(c11);
  float4 gExtraParams2 : packoffset(c12);
  float4 gExtraParams3 : packoffset(c13);
  float4 gExtraParams4 : packoffset(c14);
  float3 gPerspectiveShearParams0 : packoffset(c15);
  float3 gPerspectiveShearParams1 : packoffset(c16);
  float3 gPerspectiveShearParams2 : packoffset(c17);
  row_major float4x4 gPrevViewProj : packoffset(c18);
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

SamplerState PointSampler2_s : register(s6);
Texture2D<float4> PointSampler2 : register(t6);


// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_Position0,
  float4 v1 : TEXCOORD0,
  float4 pos : POSITION0,
  out float4 o0 : SV_Target0,
  out float2 motionVectors : SV_Target4)
{

  float4 posCurr = mul(pos.xyzw, gWorldViewProjUnjittered);
  float4 posPrev = mul(pos.xyzw, gWorldViewProjUnjitteredPrev);
  posCurr.xy = posCurr.xy/posCurr.ww;
  posPrev.xy = posPrev.xy/posPrev.ww;
  motionVectors.xy = (posPrev.xy-posCurr.xy) * float2(0.5, -0.5);
  float4 r0,r1,r2,r3,r4,r5;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.x = globalScreenSize.z;
  r0.yw = float2(0,0);
  r0.xy = v1.xy + r0.xy;
  r1.xy = r0.xy * float2(2,-2) + float2(-1,1);
  r2.xyzw = PointSampler2.SampleLevel(PointSampler2_s, r0.xy, 0).xyzw;
  r1.xy = g_projParams.xy * r1.xy;
  r1.z = 1;
  r1.xyz = r1.xyz * r2.xxx;
  r0.z = -globalScreenSize.z;
  r0.xy = v1.xy + r0.zw;
  r0.zw = r0.xy * float2(2,-2) + float2(-1,1);
  r2.xyzw = PointSampler2.SampleLevel(PointSampler2_s, r0.xy, 0).xyzw;
  r0.xy = g_projParams.xy * r0.zw;
  r0.z = 1;
  r0.xyz = r0.xyz * r2.xxx;
  r2.xy = v1.xy * float2(2,-2) + float2(-1,1);
  r2.xy = g_projParams.xy * r2.xy;
  r3.xyzw = PointSampler2.SampleLevel(PointSampler2_s, v1.xy, 0).xyzw;
  r2.z = 1;
  r3.yzw = r2.xyz * r3.xxx + -r0.xyz;
  r0.w = dot(r3.yzw, r3.yzw);
  r0.w = sqrt(r0.w);
  r3.yzw = r2.xyz * r3.xxx + -r1.xyz;
  r1.w = dot(r3.yzw, r3.yzw);
  r1.w = sqrt(r1.w);
  r0.w = cmp(r0.w < r1.w);
  r0.xyz = r0.www ? r0.xyz : r1.xyz;
  r0.xyz = -r2.xyz * r3.xxx + r0.xyz;
  r0.x = dot(r0.xyz, r0.xyz);
  r0.x = sqrt(r0.x);
  r1.y = globalScreenSize.w;
  r1.xz = float2(0,0);
  r0.yz = v1.xy + r1.xy;
  r1.xy = r0.yz * float2(2,-2) + float2(-1,1);
  r4.xyzw = PointSampler2.SampleLevel(PointSampler2_s, r0.yz, 0).xyzw;
  r5.xy = g_projParams.xy * r1.xy;
  r5.z = 1;
  r0.yzw = r5.xyz * r4.xxx;
  r3.yzw = r2.xyz * r3.xxx + -r0.yzw;
  r1.x = dot(r3.yzw, r3.yzw);
  r1.x = sqrt(r1.x);
  r1.w = -globalScreenSize.w;
  r1.yz = v1.xy + r1.zw;
  r3.yz = r1.yz * float2(2,-2) + float2(-1,1);
  r4.xyzw = PointSampler2.SampleLevel(PointSampler2_s, r1.yz, 0).xyzw;
  r5.xy = g_projParams.xy * r3.yz;
  r5.z = 1;
  r1.yzw = r5.xyz * r4.xxx;
  r3.yzw = r2.xyz * r3.xxx + -r1.yzw;
  r2.w = dot(r3.yzw, r3.yzw);
  r2.w = sqrt(r2.w);
  r1.x = cmp(r1.x < r2.w);
  r0.yzw = r1.xxx ? r0.yzw : r1.yzw;
  r0.yzw = -r2.xyz * r3.xxx + r0.yzw;
  r0.y = dot(r0.yzw, r0.yzw);
  r0.y = sqrt(r0.y);
  r0.xy = cmp(r0.xy < gExtraParams2.ww);
  r0.x = r0.y ? r0.x : 0;
  o0.xyzw = r0.xxxx ? float4(1,1,1,1) : 0;
  return;
}