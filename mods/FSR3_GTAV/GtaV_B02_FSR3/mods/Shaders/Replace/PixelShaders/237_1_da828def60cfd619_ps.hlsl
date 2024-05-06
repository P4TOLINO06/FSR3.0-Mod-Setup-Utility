// ---- FNV Hash da828def60cfd619

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

cbuffer csmshader : register(b6)
{
  float4 gCSMShaderVars_shared[12] : packoffset(c0);
  float4 gCSMDepthBias : packoffset(c12);
  float4 gCSMDepthSlopeBias : packoffset(c13);
  float4 gCSMResolution : packoffset(c14);
  float4 gCSMShadowParams : packoffset(c15);
  row_major float4x4 gLocalLightShadowData[8] : packoffset(c16);
  float4 gShadowTexParam : packoffset(c48);
}

cbuffer waterTex_locals : register(b11)
{
  float4 WaterBumpParams[2] : packoffset(c0);
  float4 gProjParams : packoffset(c2);
  float4 gFogCompositeParams : packoffset(c3);
  float4 gFogCompositeAmbientColor : packoffset(c4);
  float4 gFogCompositeDirectionalColor : packoffset(c5);
  float4 gFogCompositeTexOffset : packoffset(c6);
  float4 UpdateParams0 : packoffset(c7);
  float4 UpdateParams1 : packoffset(c8);
  float4 UpdateParams2 : packoffset(c9);
  float4 UpdateOffset : packoffset(c10);
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

SamplerState LinearSampler_s : register(s2);
Texture2D<float4> LinearSampler : register(t2);


// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_Position0,
  float2 v1 : TEXCOORD0,
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

  r0.xyzw = globalScreenSize.zwzw * float4(4,4,4,-4) + v1.xyxy;
  r1.xyzw = LinearSampler.Sample(LinearSampler_s, r0.xy).xyzw;
  r0.xyzw = LinearSampler.Sample(LinearSampler_s, r0.zw).xyzw;
  r0.xyzw = r1.xyzw + r0.xyzw;
  r1.xyzw = globalScreenSize.zwzw * float4(-4,4,-4,-4) + v1.xyxy;
  r2.xyzw = LinearSampler.Sample(LinearSampler_s, r1.xy).xyzw;
  r1.xyzw = LinearSampler.Sample(LinearSampler_s, r1.zw).xyzw;
  r0.xyzw = r2.xyzw + r0.xyzw;
  r0.xyzw = r0.xyzw + r1.xyzw;
  r1.x = cmp(0 < r0.y);
  r0.xyzw = float4(0.25,0.25,0.25,0.25) * r0.xyzw;
  r0.y = max(0.00392156886, r0.y);
  o0.y = r1.x ? r0.y : 0;
  r0.y = saturate(UpdateParams0.w * gCSMShaderVars_shared[3].x + gCSMShaderVars_shared[3].y);
  r0.y = sqrt(r0.y);
  r0.y = -r0.y * gCSMShaderVars_shared[3].z + 1;
  o0.w = r0.w * r0.y;
  o0.xz = r0.xz;
  return;
}