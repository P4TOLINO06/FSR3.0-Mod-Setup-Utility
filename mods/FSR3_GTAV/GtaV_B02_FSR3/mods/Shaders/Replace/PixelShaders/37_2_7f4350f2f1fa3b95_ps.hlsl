// ---- FNV Hash 7f4350f2f1fa3b95

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
  float specularFresnel : packoffset(c0);
  float specularFalloffMult : packoffset(c0.y);
  float specularIntensityMult : packoffset(c0.z);
  float3 specMapIntMask : packoffset(c1);
  float bumpiness : packoffset(c1.w);
  float4 umGlobalParams : packoffset(c2);
  float4 WindGlobalParams : packoffset(c3);
  float UseTreeNormals : packoffset(c4);
  float SelfShadowing : packoffset(c4.y);
  float AlphaScale : packoffset(c4.z);
  float AlphaTest : packoffset(c4.w);
  float ShadowFalloff : packoffset(c5);
  float AlphaScaleNormal : packoffset(c5.y);
  float AlphaClampNormal : packoffset(c5.z);
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
SamplerState SpecSampler_s : register(s3);
SamplerState BumpSampler_s : register(s4);
Texture2D<float4> DiffuseSampler : register(t0);
Texture2D<float4> SpecSampler : register(t3);
Texture2D<float4> BumpSampler : register(t4);


// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_Position0,
  float4 v1 : TEXCOORD0,
  float4 v2 : TEXCOORD1,
  float4 v3 : TEXCOORD2,
  float3 v4 : TEXCOORD3,
  float4 pos : POSITION0,
  uint v5 : SV_IsFrontFace0,
  out float4 o0 : SV_Target0,
  out float4 o1 : SV_Target1,
  out float4 o2 : SV_Target2,
  out float4 o3 : SV_Target3,
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
  float4 r0,r1,r2;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xy = (uint2)v0.xy;
  r0.xy = (int2)r0.xy & int2(1,1);
  r0.y = (uint)r0.y << 1;
  r0.x = (int)r0.x + (int)r0.y;
  r0.x = dot(globalFade.xyzw, icb[r0.x+0].xyzw);
  r0.x = cmp(r0.x < 1);
  if (r0.x != 0) discard;
  r0.xyzw = DiffuseSampler.Sample(DiffuseSampler_s, v1.xy).xyzw;
  r1.x = cmp(r0.w < 0.75);
  r1.y = dot(v0.xy, float2(0.5,0.5));
  r1.y = frac(r1.y);
  r1.y = cmp(r1.y < 0.5);
  r1.x = r1.y ? r1.x : 0;
  r1.y = cmp(0.100000001 >= r0.w);
  r1.x = (int)r1.y | (int)r1.x;
  if (r1.x != 0) discard;
  r0.w = -0.100000001 + r0.w;
  r0.w = saturate(r0.w * 1.53846157 + 0.00392156886);
  r1.x = AlphaScale * globalScalars.x;
  r0.w = dot(r1.xx, r0.ww);
  r1.x = cmp(0 >= gTransparencyAASamples);
  r1.y = cmp(AlphaTest >= r0.w);
  r1.x = r1.y ? r1.x : 0;
  if (r1.x != 0) discard;
  r1.x = cmp(0 != globalFogParams[0].w);
  r1.y = v5.x ? 0 : 1;
  r1.y = (int)v5.x + (int)r1.y;
  r1.y = (int)r1.y;
  r1.x = r1.x ? r1.y : 1;
  r1.xyz = v2.xyz * r1.xxx;
  r2.xyzw = BumpSampler.Sample(BumpSampler_s, v1.xy).xyzw;
  r2.xy = r2.xy * float2(2,2) + float2(-1,-1);
  r1.w = dot(r2.xy, r2.xy);
  r1.w = 1 + -r1.w;
  r1.w = sqrt(abs(r1.w));
  r2.z = max(0.00100000005, bumpiness);
  r2.xy = r2.xy * r2.zz;
  r2.yzw = v4.xyz * r2.yyy;
  r2.xyz = r2.xxx * v3.xyz + r2.yzw;
  r1.xyz = r1.www * r1.xyz + r2.xyz;
  r1.w = dot(r1.xyz, r1.xyz);
  r1.w = rsqrt(r1.w);
  r1.xyz = r1.xyz * r1.www + float3(-0,-0,-1);
  r1.xyz = UseTreeNormals * r1.xyz + float3(0,0,1);
  r2.xyzw = SpecSampler.Sample(SpecSampler_s, v1.xy).xyzw;
  r1.w = specularFalloffMult * r2.w;
  r2.x = dot(r2.xyz, specMapIntMask.xyz);
  r2.x = specularIntensityMult * r2.x;
  o2.x = 4 * r2.x;
  r1.w = 0.001953125 * r1.w;
  o2.y = sqrt(r1.w);
  o1.xyz = r1.xyz * float3(0.5,0.5,0.5) + float3(0.5,0.5,0.5);
  r1.xy = globalScalars.zy * v1.zz;
  r1.w = saturate(gDirectionalAmbientColour.w + globalScalars2.z);
  r1.z = r1.y * r1.w;
  r1.xy = float2(0.5,0.5) * r1.xz;
  o3.xy = sqrt(r1.xy);
  o0.xyz = r0.xyz;
  o0.w = r0.w;
  o1.w = 0;
  o2.z = specularFresnel;
  o2.w = v1.w;
  o3.z = 0;
  o3.w = 0.496078432 * ShadowFalloff;
  return;
}