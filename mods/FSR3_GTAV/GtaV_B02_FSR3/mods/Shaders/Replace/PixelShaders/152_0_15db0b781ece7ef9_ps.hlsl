// ---- FNV Hash 15db0b781ece7ef9

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

SamplerState DiffuseTexSampler_s : register(s5);
SamplerState FrameMapTexSampler_s : register(s6);
SamplerState RefractionMapTexSampler_s : register(s8);
SamplerState DepthMapTexSampler_s : register(s12);
Texture2D<float4> DiffuseTexSampler : register(t5);
Texture2D<float4> FrameMap : register(t6);
Texture2D<float4> RefractionMapTexSampler : register(t8);
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
  float4 r0,r1,r2,r3,r4,r5,r6;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyzw = RefractionMapTexSampler.Sample(RefractionMapTexSampler_s, v2.xy).xyzw;
  r1.xyzw = r0.xyxy * float4(2,2,2,2) + float4(-1,-1,-1,-1);
  r0.x = v0.w * r0.z;
  r0.y = gNormalMapMult * r0.x;
  r0.y = 100 * r0.y;
  r1.xyzw = r1.xyzw * r0.yyyy + v11.xyxy;
  r1.xyzw = gInvScreenSize.xyxy * r1.xyzw;
  r2.xyzw = DiffuseTexSampler.Sample(DiffuseTexSampler_s, v1.xy).xyzw;
  r2.xyz = r2.xyz * r2.xyz;
  r3.xyzw = DiffuseTexSampler.Sample(DiffuseTexSampler_s, v1.zw).xyzw;
  r3.xyz = r3.xyz * r3.xyz;
  r3.xyzw = r3.xyzw + -r2.xyzw;
  r2.xyzw = v3.xxxx * r3.xyzw + r2.xyzw;
  r3.xyzw = DepthMapTexSampler.Sample(DepthMapTexSampler_s, r1.zw).xyzw;
  r0.y = 1 + -r3.x;
  r0.zw = cmp(float2(0,0) != postProcess_FlipDepth_NearPlaneFade_Params.zw);
  r3.x = 1 + -r0.y;
  r0.y = r0.z ? r3.x : r0.y;
  r0.y = 1 + -r0.y;
  r0.y = r0.y * NearFarPlane.z + NearFarPlane.w;
  r0.y = 1 / r0.y;
  r0.y = -v7.w + r0.y;
  r0.z = saturate(1000 * r0.y);
  r0.z = v0.w * r0.z;
  r0.y = r0.y * r0.y + -v7.x;
  r3.x = saturate(v5.x * r0.y);
  r0.z = r3.x * r0.z;
  r0.y = -gSoftnessShadowOffset + r0.y;
  r0.y = saturate(v5.x * r0.y);
  r3.x = 1 + -r0.y;
  r3.y = 1 + -gSoftnessShadowMult;
  r0.y = r3.x * r3.y + r0.y;
  r3.xyz = v0.xyz * r0.yyy;
  r0.y = saturate(20 * v12.x);
  r0.y = r0.w ? r0.y : 1;
  r0.y = r0.z * r0.y;
  r0.y = r0.y * r2.w;
  r0.z = cmp(9.99999975e-05 < r0.x);
  r4.xyzw = FrameMap.SampleLevel(FrameMapTexSampler_s, r1.zw, 0).xyzw;
  if (r0.z != 0) {
    r5.xyzw = gInvScreenSize.xyxy * float4(0.5,-1.5,-1.5,-0.5) + r1.zwzw;
    r1.xyzw = gInvScreenSize.xyxy * float4(-0.5,1.5,1.5,0.5) + r1.xyzw;
    r6.xyzw = FrameMap.SampleLevel(FrameMapTexSampler_s, r5.xy, 0).xyzw;
    r6.xyz = r6.xyz + r4.xyz;
    r5.xyzw = FrameMap.SampleLevel(FrameMapTexSampler_s, r5.zw, 0).xyzw;
    r5.xyz = r6.xyz + r5.xyz;
    r6.xyzw = FrameMap.SampleLevel(FrameMapTexSampler_s, r1.xy, 0).xyzw;
    r5.xyz = r6.xyz + r5.xyz;
    r1.xyzw = FrameMap.SampleLevel(FrameMapTexSampler_s, r1.zw, 0).xyzw;
    r1.xyz = r5.xyz + r1.xyz;
    r4.xyz = float3(0.200000003,0.200000003,0.200000003) * r1.xyz;
  }
  r1.xyz = globalScalars3.www * r4.xyz;
  r2.xyz = r3.xyz * r2.xyz + -r1.xyz;
  r1.xyz = r0.yyy * r2.xyz + r1.xyz;
  o0.xyz = globalScalars3.zzz * r1.xyz;
  o2.x = gGlobalParticleDofAlphaScale * r0.y;
  o0.w = r0.x;
  o1.x = v7.w;
  return;
}