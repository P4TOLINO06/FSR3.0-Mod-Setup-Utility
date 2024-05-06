// ---- FNV Hash 44ac05f732bb687f

// ---- Created with 3Dmigoto v1.3.16 on Mon Nov 13 01:20:59 2023

cbuffer sky_system_locals : register(b12)
{
  float3 azimuthEastColor : packoffset(c0);
  float3 azimuthWestColor : packoffset(c1);
  float3 azimuthTransitionColor : packoffset(c2);
  float azimuthTransitionPosition : packoffset(c2.w);
  float3 zenithColor : packoffset(c3);
  float3 zenithTransitionColor : packoffset(c4);
  float4 zenithConstants : packoffset(c5);
  float4 skyPlaneColor : packoffset(c6);
  float4 skyPlaneParams : packoffset(c7);
  float hdrIntensity : packoffset(c8);
  float3 sunColor : packoffset(c8.y);
  float3 sunColorHdr : packoffset(c9);
  float3 sunDiscColorHdr : packoffset(c10);
  float4 sunConstants : packoffset(c11);
  float3 sunDirection : packoffset(c12);
  float3 sunPosition : packoffset(c13);
  float3 cloudBaseMinusMidColour : packoffset(c14);
  float3 cloudMidColour : packoffset(c15);
  float3 cloudShadowMinusBaseColourTimesShadowStrength : packoffset(c16);
  float4 cloudDetailConstants : packoffset(c17);
  float4 cloudConstants1 : packoffset(c18);
  float4 cloudConstants2 : packoffset(c19);
  float4 smallCloudConstants : packoffset(c20);
  float3 smallCloudColorHdr : packoffset(c21);
  float4 effectsConstants : packoffset(c22);
  float horizonLevel : packoffset(c23);
  float3 speedConstants : packoffset(c23.y);
  float starfieldIntensity : packoffset(c24);
  float3 moonDirection : packoffset(c24.y);
  float3 moonPosition : packoffset(c25);
  float moonIntensity : packoffset(c25.w);
  float3 lunarCycle : packoffset(c26);
  float3 moonColor : packoffset(c27);
  float noiseFrequency : packoffset(c27.w);
  float noiseScale : packoffset(c28);
  float noiseThreshold : packoffset(c28.y);
  float noiseSoftness : packoffset(c28.z);
  float noiseDensityOffset : packoffset(c28.w);
  float2 noisePhase : packoffset(c29);
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

SamplerState ditherSampler_s : register(s6);
Texture2D<float4> ditherSampler : register(t6);


// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_Position0,
  float4 v1 : TEXCOORD0,
  float4 v2 : TEXCOORD1,
  float4 v3 : TEXCOORD2,
  float4 v4 : TEXCOORD3,
  float4 v5 : TEXCOORD4,
  float4 v6 : TEXCOORD5,
  float4 v7 : TEXCOORD6,
  float4 pos : POSITION0,
  out float4 o0 : SV_Target0,
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

  r0.x = dot(v2.xyzw, v2.xyzw);
  r0.x = rsqrt(r0.x);
  r0.xyz = v2.xyz * r0.xxx;
  r0.x = dot(r0.xyz, -sunDirection.xyz);
  r0.y = -sunConstants.x * r0.x + sunConstants.y;
  r0.x = r0.x * r0.x + 1;
  r0.y = log2(abs(r0.y));
  r0.y = 1.5 * r0.y;
  r0.y = exp2(r0.y);
  r0.x = r0.x / r0.y;
  r0.y = sunConstants.z * r0.x;
  r0.x = saturate(-r0.x * sunConstants.z + 1);
  r0.y = saturate(r0.y);
  r0.yzw = sunColorHdr.xyz * r0.yyy;
  r0.yzw = sunConstants.www * r0.yzw;
  r0.xyz = v3.xyz * r0.xxx + r0.yzw;
  r1.xyz = v7.xyz + -r0.xyz;
  r0.xyz = v7.www * r1.xyz + r0.xyz;
  r1.xyzw = ditherSampler.Sample(ditherSampler_s, v5.xy).xyzw;
  r0.w = -0.5 + r1.x;
  o0.xyz = r0.www * float3(9.99999975e-05,9.99999975e-05,9.99999975e-05) + r0.xyz;
  o0.w = saturate(v2.w);
  return;
}