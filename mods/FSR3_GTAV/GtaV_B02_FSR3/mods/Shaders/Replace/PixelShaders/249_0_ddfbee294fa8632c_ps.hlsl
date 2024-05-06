// ---- FNV Hash ddfbee294fa8632c

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

cbuffer rage_SoftParticleBuffer : register(b5)
{
  float4 NearFarPlane : packoffset(c0);
  float4 gInvScreenSize : packoffset(c1);
}

cbuffer ptxgpu_render_locals : register(b8)
{
  float gLightIntensityMult : packoffset(c0);
  float4 gTextureRowsColsStartEnd : packoffset(c1);
  float4 gTextureAnimRateScaleOverLifeStart2End2 : packoffset(c2);
  float4 gSizeMinRange : packoffset(c3);
  float4 gColour : packoffset(c4);
  float2 gFadeInOut : packoffset(c5);
  float2 gRotSpeedMinRange : packoffset(c5.z);
  float3 gDirectionalZOffsetMinRange : packoffset(c6);
  float2 gFadeNearFar : packoffset(c7);
  float3 gFadeZBaseLoHi : packoffset(c8);
  float3 gDirectionalVelocityAdd : packoffset(c9);
  float gEdgeSoftness : packoffset(c9.w);
  float gMaxLife : packoffset(c10);
  float3 gRefParticlePos : packoffset(c10.y);
  float gParticleColorPercentage : packoffset(c11);
  float gBackgroundDistortionVisibilityPercentage : packoffset(c11.y);
  float gBackgroundDistortionAlphaBooster : packoffset(c11.z);
  float gBackgroundDistortionAmount : packoffset(c11.w);
  float gDirectionalLightShadowAmount : packoffset(c12);
  float gLocalLightsMultiplier : packoffset(c12.y);
  float4 gCamAngleLimits : packoffset(c13);
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

SamplerState DiffuseSampler_s : register(s7);
SamplerState BackBufferSampler_s : register(s8);
SamplerState DistortionSampler_s : register(s9);
Texture2D<float4> DiffuseSampler : register(t7);
Texture2D<float4> BackBufferSampler : register(t8);
Texture2D<float4> DistortionSampler : register(t9);


// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : TEXCOORD0,
  float4 v1 : TEXCOORD1,
  float4 v2 : TEXCOORD2,
  nointerpolation float4 v3 : TEXCOORD4,
  float4 v4 : TEXCOORD5,
  nointerpolation float2 v5 : TEXCOORD6,
  float4 v6 : SV_Position0,
  float4 v7 : SV_ClipDistance0,
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
  float4 r0,r1,r2,r3;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyz = v4.xyz * v3.xyz;
  r1.xyzw = DiffuseSampler.Sample(DiffuseSampler_s, v1.xy).xyzw;
  r2.xyzw = DiffuseSampler.Sample(DiffuseSampler_s, v1.zw).xyzw;
  r0.w = v5.y * r2.w;
  r0.w = r1.w * v5.x + r0.w;
  r0.w = saturate(v3.w * r0.w);
  r1.x = cmp(0 < gBackgroundDistortionAmount);
  if (r1.x != 0) {
    r1.x = -v6.z * v6.z + 1;
    r2.xyzw = DistortionSampler.Sample(DistortionSampler_s, v1.xy).xyzw;
    r3.xyzw = DistortionSampler.Sample(DistortionSampler_s, v1.zw).xyzw;
    r1.yzw = v5.yyy * r3.xyz;
    r1.yzw = r2.xyz * v5.xxx + r1.yzw;
    r1.yz = r1.yz * float2(2,2) + float2(-1,-1);
    r1.yz = r1.ww * r1.yz;
    r1.yz = gInvScreenSize.xy * r1.yz;
    r1.x = gBackgroundDistortionAmount * r1.x;
    r1.xy = r1.yz * r1.xx;
  } else {
    r1.xy = float2(0,0);
  }
  r1.xy = v6.xy * gInvScreenSize.xy + r1.xy;
  r1.xyzw = BackBufferSampler.Sample(BackBufferSampler_s, r1.xy).xyzw;
  r1.xyz = gBackgroundDistortionVisibilityPercentage * r1.xyz;
  r0.xyz = r0.xyz * gParticleColorPercentage + r1.xyz;
  o0.xyz = globalScalars3.zzz * r0.xyz;
  r0.x = cmp(0.150000006 < r0.w);
  r0.x = r0.x ? 1.000000 : 0;
  r0.y = 1 + -v4.w;
  o1.x = r0.y * r0.x;
  o0.w = r0.w;
  o2.x = r0.x;
  return;
}