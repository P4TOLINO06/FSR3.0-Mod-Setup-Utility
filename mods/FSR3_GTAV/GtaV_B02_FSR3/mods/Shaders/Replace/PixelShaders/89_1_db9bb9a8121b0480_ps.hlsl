// ---- FNV Hash db9bb9a8121b0480

// ---- Created with 3Dmigoto v1.3.16 on Sat Nov  4 12:47:21 2023

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

cbuffer distance_map_locals : register(b12)
{
  float3 fillColor : packoffset(c0);
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

SamplerState distanceMapSampler_s : register(s2);
Texture2D<float4> distanceMapSampler : register(t2);


// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_Position0,
  float4 v1 : TEXCOORD0,
  float4 v2 : TEXCOORD1,
  float4 v3 : TEXCOORD2,
  float3 v4 : TEXCOORD3,
  float4 pos : POSITION0,
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
  float4 r0,r1;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xy = ddx(v1.xy);
  r0.zw = ddy(v1.xy);
  r0.xy = max(abs(r0.xy), abs(r0.zw));
  r0.x = max(r0.x, r0.y);
  r0.y = r0.x * 10 + 0.5;
  r0.x = -r0.x * 10 + 0.5;
  r0.y = r0.y + -r0.x;
  r0.y = 1 / r0.y;
  r1.xyzw = distanceMapSampler.SampleLevel(distanceMapSampler_s, v1.xy, 0).xyzw;
  r0.x = r1.x + -r0.x;
  r0.x = saturate(r0.x * r0.y);
  r0.y = r0.x * -2 + 3;
  r0.x = r0.x * r0.x;
  r0.x = r0.y * r0.x;
  o0.w = r0.x;
  o3.w = r0.x;
  r0.x = dot(v3.xyz, v3.xyz);
  r0.x = rsqrt(r0.x);
  r0.y = v3.z * r0.x + -0.349999994;
  r0.xzw = v3.xyz * r0.xxx;
  o1.xyz = r0.xzw * float3(0.5,0.5,0.5) + float3(0.5,0.5,0.5);
  r0.x = saturate(1.53846157 * r0.y);
  r0.x = gDynamicBakesAndWetness.z * r0.x;
  r0.x = v2.x * r0.x;
  r0.y = r0.x * -0.5 + 1;
  r0.xz = float2(0.5,0.48828125) * r0.xx;
  o2.xy = sqrt(r0.xz);
  o0.xyz = fillColor.xyz * r0.yyy;
  o1.w = 0;
  o2.zw = float2(0.980000019,0);
  r0.x = gLightArtificialIntAmbient0.w + v2.x;
  r0.y = v2.y;
  r0.xy = float2(0.5,0.5) * r0.xy;
  o3.xy = sqrt(r0.xy);
  o3.z = 0;
  return;
}