// ---- FNV Hash d1ea9a3d06f69ebc

// ---- Created with 3Dmigoto v1.3.16 on Sat Nov 11 18:21:54 2023

cbuffer rage_matrices : register(b1)
{
  row_major float4x4 gWorld : packoffset(c0);
  row_major float4x4 gWorldView : packoffset(c4);
  row_major float4x4 gWorldViewProj : packoffset(c8);
  row_major float4x4 gViewInverse : packoffset(c12);
  row_major float4x4 gWorldViewProjUnjittered : packoffset(c16);
  row_major float4x4 gWorldViewProjUnjitteredPrev : packoffset(c20);
}

cbuffer lighting_locals : register(b11)
{
  float4 deferredLightParams[14] : packoffset(c0);
  float4 deferredLightVolumeParams[2] : packoffset(c14);
  float4 deferredLightScreenSize : packoffset(c16);
  float4 deferredProjectionParams : packoffset(c17);
  float3 deferredPerspectiveShearParams0 : packoffset(c18);
  float3 deferredPerspectiveShearParams1 : packoffset(c19);
  float3 deferredPerspectiveShearParams2 : packoffset(c20);
}

cbuffer deferred_volume_locals : register(b10)
{
  float4 deferredVolumePosition : packoffset(c0);
  float4 deferredVolumeDirection : packoffset(c1);
  float4 deferredVolumeTangentXAndShaftRadius : packoffset(c2);
  float4 deferredVolumeTangentYAndShaftLength : packoffset(c3);
  float4 deferredVolumeColour : packoffset(c4);
  float4 deferredVolumeShaftPlanes[3] : packoffset(c5);
  float4 deferredVolumeShaftGradient : packoffset(c8);
  float4 deferredVolumeShaftGradientColourInv : packoffset(c9);
  row_major float4x4 deferredVolumeShaftCompositeMtx : packoffset(c10);
}

SamplerState deferredVolumeDepthBufferSamp_s : register(s5);
Texture2D<float4> deferredVolumeDepthBufferSamp : register(t5);


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

  r0.xy = v2.xy / v2.ww;
  r0.xyzw = deferredVolumeDepthBufferSamp.Sample(deferredVolumeDepthBufferSamp_s, r0.xy).xyzw;
  r0.y = 1 + deferredProjectionParams.w;
  r0.x = r0.y + -r0.x;
  r0.x = deferredProjectionParams.z / r0.x;
  r0.x = saturate(r0.x / v2.w);
  r0.y = r0.x * r0.x;
  r1.xyz = v3.xyz / v4.xyz;
  r0.z = max(r1.x, r1.y);
  r0.z = max(r0.z, r1.z);
  r0.w = r0.z + r0.x;
  r0.x = saturate(r0.x + -r0.z);
  r0.y = r0.z * r0.w + r0.y;
  r1.xyz = -gViewInverse._m30_m31_m32 + v1.xyz;
  r0.z = dot(deferredVolumeShaftGradient.xyz, r1.xyz);
  r1.x = dot(r1.xyz, r1.xyz);
  r1.x = sqrt(r1.x);
  r1.y = r0.z * r0.z;
  r0.y = r1.y * r0.y;
  r2.xyz = gViewInverse._m30_m31_m32;
  r2.w = 1;
  r1.y = dot(deferredVolumeShaftGradient.xyzw, r2.xyzw);
  r0.z = r1.y * r0.z;
  r0.z = r0.w * r0.z;
  r0.z = r1.y * r1.y + r0.z;
  r0.y = r0.y * 0.333333343 + r0.z;
  r0.y = log2(abs(r0.y));
  r0.yzw = deferredVolumeShaftGradientColourInv.xyz * r0.yyy;
  r0.yzw = exp2(r0.yzw);
  r0.xyz = r0.xxx * r0.yzw;
  r0.xyz = r0.xyz * r1.xxx;
  r1.xyz = r0.xyz * v2.zzz + float3(-1,-1,-1);
  r0.xyz = v2.zzz * r0.xyz;
  r1.xyz = deferredVolumeShaftGradientColourInv.www * r1.xyz + float3(1,1,1);
  r0.xyz = r1.xyz * r0.xyz;
  o0.xyz = deferredVolumeColour.xyz * r0.xyz;
  o0.w = 0;
  return;
}