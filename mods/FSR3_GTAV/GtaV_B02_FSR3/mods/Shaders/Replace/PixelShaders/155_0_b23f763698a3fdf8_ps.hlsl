// ---- FNV Hash b23f763698a3fdf8

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
Texture2D<float4> FogRayTexSampler : register(t4);
Texture2D<float4> DiffuseTexSampler : register(t5);


// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : TEXCOORD0,
  float4 v1 : TEXCOORD1,
  float4 v2 : TEXCOORD2,
  float4 v3 : SV_Position0,
  float4 v4 : SV_ClipDistance0,
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
  float4 r0,r1;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.x = cmp(0 < gGlobalFogIntensity);
  if (r0.x != 0) {
    r0.xy = gInvScreenSize.xy * v3.xy;
    r0.xyzw = FogRayTexSampler.Sample(FogRayTexSampler_s, r0.xy).xyzw;
    r0.x = -1 + r0.x;
    r0.x = saturate(gGlobalFogIntensity * r0.x + 1);
    r0.x = v2.w * r0.x;
  } else {
    r0.x = v2.w;
  }
  r1.xyzw = DiffuseTexSampler.Sample(DiffuseTexSampler_s, v1.xy).xyzw;
  r0.yzw = r1.xyz * r1.xyz;
  r0.yzw = v0.xyz * r0.yzw;
  r1.xyz = float3(16,16,16) * r0.yzw;
  r1.w = saturate(v0.w * r1.w);
  r0.yzw = -r0.yzw * float3(16,16,16) + v2.xyz;
  r0.xyz = r0.xxx * r0.yzw + r1.xyz;
  o0.xyz = globalScalars3.zzz * r0.xyz;
  o2.x = gGlobalParticleDofAlphaScale * r1.w;
  o0.w = r1.w;
  o1.x = v1.z;
  return;
}