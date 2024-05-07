// ---- FNV Hash 88c133ac5764f10b

// ---- Created with 3Dmigoto v1.3.16 on Sat Nov  4 12:47:20 2023

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

cbuffer lighting_globals : register(b3)
{
  float4 gDirectionalLight : packoffset(c0);
  float4 gDirectionalColour : packoffset(c1);
  int gNumForwardLights : packoffset(c2);
  float4 gLightPositionAndInvDistSqr[8] : packoffset(c3);
  float4 gLightDirectionAndFalloffExponent[8] : packoffset(c11);
  float4 gLightColourAndCapsuleExtent[8] : packoffset(c19);
  float gLightConeScale[8] : packoffset(c27);
  float gLightConeOffset[8] : packoffset(c35);
  float4 gLightNaturalAmbient0 : packoffset(c43);
  float4 gLightNaturalAmbient1 : packoffset(c44);
  float4 gLightArtificialIntAmbient0 : packoffset(c45);
  float4 gLightArtificialIntAmbient1 : packoffset(c46);
  float4 gLightArtificialExtAmbient0 : packoffset(c47);
  float4 gLightArtificialExtAmbient1 : packoffset(c48);
  float4 gDirectionalAmbientColour : packoffset(c49);
  float4 globalFogParams[5] : packoffset(c50);
  float4 globalFogColor : packoffset(c55);
  float4 globalFogColorE : packoffset(c56);
  float4 globalFogColorN : packoffset(c57);
  float4 globalFogColorMoon : packoffset(c58);
  float4 gReflectionTweaks : packoffset(c59);
}

cbuffer more_stuff : register(b5)
{
  float4 gEntitySelectColor[2] : packoffset(c0);
  float4 gAmbientOcclusionEffect : packoffset(c2);
  float4 gDynamicBakesAndWetness : packoffset(c3);
  float4 gAlphaRefVec0 : packoffset(c4);
  float4 gAlphaRefVec1 : packoffset(c5);
  float gAlphaTestRef : packoffset(c6);
  bool gTreesUseDiscard : packoffset(c6.y);
  float gReflectionMipCount : packoffset(c6.z);
  float gTransparencyAASamples : packoffset(c6.w);
  bool gUseFogRay : packoffset(c7);
}

cbuffer trees_common_locals : register(b12)
{
  float4 umGlobalParams : packoffset(c0);
  float4 WindGlobalParams : packoffset(c1);
  float UseTreeNormals : packoffset(c2);
  float SelfShadowing : packoffset(c2.y);
  float AlphaScale : packoffset(c2.z);
  float AlphaTest : packoffset(c2.w);
  float ShadowFalloff : packoffset(c3);
  float AlphaScaleNormal : packoffset(c3.y);
  float AlphaClampNormal : packoffset(c3.z);
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

SamplerState DiffuseSampler_s : register(s0);
Texture2D<float4> DiffuseSampler : register(t0);


// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_Position0,
  float4 v1 : TEXCOORD0,
  float3 v2 : TEXCOORD1,
  float4 pos : POSITION0,
  uint v3 : SV_IsFrontFace0,
  out float4 o0 : SV_Target0,
  out float4 o1 : SV_Target1,
  out float4 o2 : SV_Target2,
  out float4 o3 : SV_Target3,
  out uint oMask : SV_Coverage,
  out float2 motionVectors : SV_Target4)
{

  float4 posCurr = mul(pos.xyzw, gWorldViewProjUnjittered);
  float4 posPrev = mul(pos.xyzw, gWorldViewProjUnjitteredPrev);
  posCurr.xy = posCurr.xy/posCurr.ww;
  posPrev.xy = posPrev.xy/posPrev.ww;
  motionVectors.xy = (posPrev.xy-posCurr.xy) * float2(0.5, -0.5);
  const float4 icb[] = { { 1.000000, 0, 0, 0},
                              { 0, 1.000000, 0, 0},
                              { 0, 0, 1.000000, 0},
                              { 0, 0, 0, 1.000000} };
  float4 r0,r1;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.x = cmp(0 < gTransparencyAASamples);
  if (r0.x != 0) {
    r0.x = AlphaScale * globalScalars.x;
    r0.yz = float2(0,0);
    while (true) {
      r0.w = cmp((uint)r0.z >= (uint)gTargetAAParams.x);
      if (r0.w != 0) break;
      r1.xy = EvaluateAttributeAtSample(v1.xy, r0.z);
      r0.w = DiffuseSampler.Sample(DiffuseSampler_s, r1.xy).w;
      r0.w = dot(r0.ww, r0.xx);
      r0.w = cmp(AlphaTest < r0.w);
      bitmask.x = ((~(-1 << (uint)1)) << (uint)r0.z) & 0xffffffff;  r1.x = (((uint)1 << (uint)r0.z) & bitmask.x) | ((uint)r0.y & ~bitmask.x);
      r0.y = r0.w ? r1.x : r0.y;
      r0.z = (int)r0.z + 1;
    }
    r0.x = cmp((int)r0.y == 0);
    if (r0.x != 0) discard;
    oMask = r0.y;
  } else {
    oMask = -1;
  }
  r0.x = cmp(gTreesUseDiscard != 0);
  r0.yz = (uint2)v0.xy;
  bitmask.z = ((~(-1 << (uint)1)) << (uint)1) & 0xffffffff;  r0.z = (((uint)r0.z << (uint)1) & bitmask.z) | ((uint)0 & ~bitmask.z);
  bitmask.y = ((~(-1 << (uint)1)) << (uint)0) & 0xffffffff;  r0.y = (((uint)r0.y << (uint)0) & bitmask.y) | ((uint)r0.z & ~bitmask.y);
  r0.y = dot(globalFade.xyzw, icb[r0.y+0].xyzw);
  r0.y = cmp(r0.y < 1);
  r0.x = r0.y ? r0.x : 0;
  if (r0.x != 0) discard;
  r0.xyzw = DiffuseSampler.Sample(DiffuseSampler_s, v1.xy).xyzw;
  r1.x = AlphaScale * globalScalars.x;
  r0.w = dot(r1.xx, r0.ww);
  r1.x = cmp(0 >= gTransparencyAASamples);
  r1.y = cmp(AlphaTest >= r0.w);
  r1.x = r1.y ? r1.x : 0;
  if (r1.x != 0) discard;
  r1.xy = globalScalars.zy * v1.zz;
  r1.w = saturate(gDirectionalAmbientColour.w + globalScalars2.z);
  r1.z = r1.y * r1.w;
  r1.xy = float2(0.5,0.5) * r1.xz;
  o3.xy = sqrt(r1.xy);
  o0.xyzw = r0.xyzw;
  o1.xyz = v2.xyz;
  o1.w = 0;
  o2.xyz = float3(0,0,0);
  o2.w = v1.w;
  o3.z = 0;
  o3.w = 0.496078432 * ShadowFalloff;
  return;
}