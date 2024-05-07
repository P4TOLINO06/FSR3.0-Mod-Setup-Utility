// ---- FNV Hash 9d921771ae2f4293

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



// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_Position0,
  float v1 : TEXCOORD0,
  float4 pos : POSITION0,
  out float4 o0 : SV_Target0,
  out float2 motionVectors : SV_Target4)
{

  float4 posCurr = mul(pos.xyzw, gWorldViewProjUnjittered);
  float4 posPrev = mul(pos.xyzw, gWorldViewProjUnjitteredPrev);
  posCurr.xy = posCurr.xy/posCurr.ww;
  posPrev.xy = posPrev.xy/posPrev.ww;
  motionVectors.xy = (posPrev.xy-posCurr.xy) * float2(0.5, -0.5);
  float4 r0;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xy = float2(-0.5,-0.5) + v0.xy;
  r0.xy = float2(0.5,0.5) * r0.xy;
  r0.xy = frac(r0.xy);
  r0.x = dot(r0.xy, float2(1,2));
  r0.x = r0.x * 0.5 + 0.200000003;
  r0.x = cmp(r0.x >= v1.x);
  r0.y = cmp(v1.x < noiseThreshold);
  r0.x = (int)r0.y | (int)r0.x;
  if (r0.x != 0) discard;
  o0.xyzw = float4(1,1,1,1);
  return;
}