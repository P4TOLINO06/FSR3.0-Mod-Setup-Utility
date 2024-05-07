// ---- FNV Hash a3d936448d5eac6c

// ---- Created with 3Dmigoto v1.3.16 on Sat Nov 11 18:21:54 2023

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

cbuffer rage_SoftParticleBuffer : register(b5)
{
  float4 NearFarPlane : packoffset(c0);
  float4 gInvScreenSize : packoffset(c1);
}

cbuffer ptfx_common_locals : register(b9)
{
  float4 deferredLightScreenSize : packoffset(c0);
  float4 deferredProjectionParams : packoffset(c1);
  float3 deferredPerspectiveShearParams0 : packoffset(c2);
  float3 deferredPerspectiveShearParams1 : packoffset(c3);
  float3 deferredPerspectiveShearParams2 : packoffset(c4);
  float4 postProcess_FlipDepth_NearPlaneFade_Params : packoffset(c5);
  float4 waterfogPtfxParams : packoffset(c6);
  float4 activeShadowCascades : packoffset(c7);
  float4 numActiveShadowCascades : packoffset(c8);
}

cbuffer ptfx_sprite_locals2 : register(b8)
{
  float gBlendMode : packoffset(c0);
  float4 gChannelMask : packoffset(c1);
  float gSuperAlpha : packoffset(c2);
  float gDirectionalMult : packoffset(c2.y);
  float gAmbientMult : packoffset(c2.z);
  float gShadowAmount : packoffset(c2.w);
  float gExtraLightMult : packoffset(c3);
  float gCameraBias : packoffset(c3.y);
  float gCameraShrink : packoffset(c3.z);
  float gNormalArc : packoffset(c3.w);
  float gDirNormalBias : packoffset(c4);
  float gSoftnessCurve : packoffset(c4.y);
  float gSoftnessShadowMult : packoffset(c4.z);
  float gSoftnessShadowOffset : packoffset(c4.w);
  float gNormalMapMult : packoffset(c5);
  float3 gAlphaCutoffMinMax : packoffset(c5.y);
  float gRG_BlendStartDistance : packoffset(c6);
  float gRG_BlendEndDistance : packoffset(c6.y);
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

SamplerState FogRayTexSampler_s : register(s4);
SamplerState DiffuseTexSampler_s : register(s5);
SamplerState DepthMapTexSampler_s : register(s12);
Texture2D<float4> FogRayTexSampler : register(t4);
Texture2D<float4> DiffuseTexSampler : register(t5);
Texture2D<float4> DepthMapTexSampler : register(t12);


// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : TEXCOORD0,
  float4 v1 : TEXCOORD1,
  float4 v2 : TEXCOORD2,
  nointerpolation float4 v3 : TEXCOORD3,
  float4 v4 : TEXCOORD5,
  nointerpolation float4 v5 : TEXCOORD6,
  float4 v6 : TEXCOORD7,
  float4 v7 : TEXCOORD8,
  float4 v8 : TEXCOORD9,
  float4 v9 : TEXCOORD10,
  float4 v10 : TEXCOORD11,
  float4 v11 : SV_Position0,
  float4 v12 : SV_ClipDistance0,
  float4 pos : POSITION0,
  out float4 o0 : SV_Target0,
  out float o1 : SV_Target1,
  out float o2 : SV_Target2,
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

  r0.xyzw = DiffuseTexSampler.Sample(DiffuseTexSampler_s, v1.xy).xyzw;
  r1.xyzw = DiffuseTexSampler.Sample(DiffuseTexSampler_s, v1.zw).xyzw;
  r0.w = r1.w + r0.w;
  r0.w = cmp(r0.w < 0.00499999989);
  if (r0.w != 0) discard;
  r0.xyz = r0.xyz * r0.xyz;
  r1.xyz = r1.xyz * r1.xyz + -r0.xyz;
  r0.xyz = v3.xxx * r1.xyz + r0.xyz;
  r1.xy = gInvScreenSize.xy * v11.xy;
  r2.xyzw = DepthMapTexSampler.Sample(DepthMapTexSampler_s, r1.xy).xyzw;
  r0.w = 1 + -r2.x;
  r1.z = cmp(0 != postProcess_FlipDepth_NearPlaneFade_Params.z);
  r1.w = 1 + -r0.w;
  r0.w = r1.z ? r1.w : r0.w;
  r0.w = 1 + -r0.w;
  r0.w = r0.w * NearFarPlane.z + NearFarPlane.w;
  r0.w = 1 / r0.w;
  r0.w = -v7.w + r0.w;
  r0.w = r0.w * r0.w + -v7.x;
  r0.w = -gSoftnessShadowOffset + r0.w;
  r0.w = saturate(v5.x * r0.w);
  r1.z = 1 + -r0.w;
  r1.w = 1 + -gSoftnessShadowMult;
  r0.w = r1.z * r1.w + r0.w;
  r2.xyz = v0.xyz * r0.www;
  r0.xyz = r2.xyz * r0.xyz;
  r0.w = cmp(0 < gGlobalFogIntensity);
  if (r0.w != 0) {
    r1.xyzw = FogRayTexSampler.Sample(FogRayTexSampler_s, r1.xy).xyzw;
    r0.w = -1 + r1.x;
    r0.w = saturate(gGlobalFogIntensity * r0.w + 1);
    r0.w = v4.w * r0.w;
  } else {
    r0.w = v4.w;
  }
  r0.w = 1 + -r0.w;
  r0.w = v0.w * r0.w;
  r0.xyz = r0.www * r0.xyz;
  r0.w = saturate(dot(r0.xyz, float3(0.298999995,0.587000012,0.114)));
  o0.xyz = globalScalars3.zzz * r0.xyz;
  r0.x = gGlobalParticleDofAlphaScale * r0.w;
  o0.w = r0.w;
  r0.y = v7.w;
  o1.x = r0.y;
  o2.x = r0.x;
  return;
}