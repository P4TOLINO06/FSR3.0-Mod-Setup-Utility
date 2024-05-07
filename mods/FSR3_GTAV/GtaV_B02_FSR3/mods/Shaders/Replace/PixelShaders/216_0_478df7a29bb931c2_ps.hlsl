// ---- FNV Hash 478df7a29bb931c2

// ---- Created with 3Dmigoto v1.3.16 on Mon Nov 13 01:20:59 2023

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

cbuffer rage_matrices : register(b1)
{
  row_major float4x4 gWorld : packoffset(c0);
  row_major float4x4 gWorldView : packoffset(c4);
  row_major float4x4 gWorldViewProj : packoffset(c8);
  row_major float4x4 gViewInverse : packoffset(c12);
  row_major float4x4 gWorldViewProjUnjittered : packoffset(c16);
  row_major float4x4 gWorldViewProjUnjitteredPrev : packoffset(c20);
}

SamplerState FogSampler_s : register(s3);
Texture2D<float4> FogSampler : register(t3);


// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_Position0,
  float4 v1 : TEXCOORD0,
  float4 v2 : TEXCOORD1,
  float4 pos : POSITION0,
  out float4 o0 : SV_Target0,
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

  r0.x = dot(v2.xyz, v2.xyz);
  r0.y = sqrt(r0.x);
  r0.x = rsqrt(r0.x);
  r1.x = -globalFogParams[0].x + r0.y;
  r1.x = max(0, r1.x);
  r0.y = r1.x / r0.y;
  r0.xyzw = v2.xzyz * r0.xyxx;
  r1.y = globalFogParams[2].z * r0.y;
  r0.y = cmp(0.00999999978 < abs(r0.y));
  r1.z = -1.44269502 * r1.y;
  r1.z = exp2(r1.z);
  r1.z = 1 + -r1.z;
  r1.y = r1.z / r1.y;
  r0.y = r0.y ? r1.y : 1;
  r1.y = globalFogParams[1].w * r1.x;
  r0.y = r1.y * r0.y;
  r0.y = min(1, r0.y);
  r0.y = 1.44269502 * r0.y;
  r0.y = exp2(r0.y);
  r0.y = min(1, r0.y);
  r0.y = 1 + -r0.y;
  r1.y = -r0.y * globalFogParams[2].y + 1;
  r0.y = globalFogParams[2].y * r0.y;
  r1.z = saturate(dot(r0.xzw, globalFogParams[3].xyz));
  r0.x = saturate(dot(r0.xzw, globalFogParams[4].xyz));
  r0.x = log2(r0.x);
  r0.x = globalFogParams[4].w * r0.x;
  r0.x = exp2(r0.x);
  r0.z = log2(r1.z);
  r0.z = globalFogParams[3].w * r0.z;
  r0.z = exp2(r0.z);
  r2.xyz = globalFogColorMoon.xyz + -globalFogColorE.xyz;
  r2.xyz = r0.xxx * r2.xyz + globalFogColorE.xyz;
  r3.xyz = globalFogColor.xyz + -r2.xyz;
  r0.xzw = r0.zzz * r3.xyz + r2.xyz;
  r0.xzw = -globalFogColorN.xyz + r0.xzw;
  r1.z = -globalFogParams[1].z * r1.x;
  r1.x = -globalFogParams[2].x + r1.x;
  r1.x = max(0, r1.x);
  r1.xy = globalFogParams[1].xy * r1.xy;
  r1.x = 1.44269502 * r1.x;
  r1.x = exp2(r1.x);
  r1.x = 1 + -r1.x;
  r0.y = saturate(r1.y * r1.x + r0.y);
  r1.x = 1.44269502 * r1.z;
  r1.x = exp2(r1.x);
  r1.x = 1 + -r1.x;
  r0.xzw = r1.xxx * r0.xzw + globalFogColorN.xyz;
  r2.x = globalFogColor.w + -r0.x;
  r2.y = globalFogColorE.w + -r0.z;
  r2.z = globalFogColorN.w + -r0.w;
  r0.xzw = r1.yyy * r2.xyz + r0.xzw;
  r1.xyzw = FogSampler.Sample(FogSampler_s, v1.xy).xyzw;
  r1.xyz = r1.xyz * r1.xyz;
  r1.w = saturate(-gDirectionalLight.z);
  r2.xyz = r1.www * gDirectionalColour.xyz + gLightNaturalAmbient0.xyz;
  r0.xzw = -r1.xyz * r2.xyz + r0.xzw;
  r1.xyz = r2.xyz * r1.xyz;
  o0.xyz = r0.yyy * r0.xzw + r1.xyz;
  o0.w = 1;
  return;
}