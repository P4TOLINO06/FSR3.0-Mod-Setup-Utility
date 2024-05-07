// ---- FNV Hash e29ba4ce8a251f8a

// ---- Created with 3Dmigoto v1.3.16 on Mon Nov 13 01:20:59 2023

cbuffer im_cbuffer : register(b5)
{
  float4 TexelSize : packoffset(c0);
  float4 refMipBlurParams : packoffset(c1);
  float4 GeneralParams0 : packoffset(c2);
  float4 GeneralParams1 : packoffset(c3);
  float g_fBilateralCoefficient : packoffset(c4);
  float g_fBilateralEdgeThreshold : packoffset(c4.y);
  float DistantCarAlpha : packoffset(c4.z);
  float4 tonemapColorFilterParams0 : packoffset(c5);
  float4 tonemapColorFilterParams1 : packoffset(c6);
  float4 RenderTexMSAAParam : packoffset(c7);
  float4 RenderPointMapINTParam : packoffset(c8);
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

SamplerState RefMipBlurSampler_s : register(s4);
Texture2D<float4> RefMipBlurSampler : register(t4);


// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_Position0,
  float4 v1 : TEXCOORD0,
  float4 pos : POSITION0,
  out float4 o0 : SV_Target0,
  out float2 motionVectors : SV_Target4)
{

  float4 posCurr = mul(pos.xyzw, gWorldViewProjUnjittered);
  float4 posPrev = mul(pos.xyzw, gWorldViewProjUnjitteredPrev);
  posCurr.xy = posCurr.xy/posCurr.ww;
  posPrev.xy = posPrev.xy/posPrev.ww;
  motionVectors.xy = (posPrev.xy-posCurr.xy) * float2(0.5, -0.5);
  float4 r0,r1,r2,r3,r4,r5,r6,r7;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.x = cmp(v1.x >= 0.5);
  r1.xzw = r0.xxx ? float3(0.25,0.75,0.5) : float3(0.75,0.25,0.5);
  r0.xy = r0.xx ? float2(-0.75,-0.5) : float2(-0.25,-0.5);
  r0.z = trunc(refMipBlurParams.x);
  r0.z = -1 + r0.z;
  r2.xy = float2(0.5,1) * refMipBlurParams.ww;
  r3.zw = r1.xw;
  r4.xyz = float3(0,0,0);
  r0.w = 0;
  while (true) {
    r2.z = cmp((int)r0.w >= 3);
    if (r2.z != 0) break;
    r2.z = (int)r0.w;
    r5.y = -1 + r2.z;
    r6.xyz = r4.xyz;
    r2.z = 0;
    while (true) {
      r2.w = cmp((int)r2.z >= 3);
      if (r2.w != 0) break;
      r2.w = (int)r2.z;
      r5.x = -1 + r2.w;
      r5.xz = r5.xy * r2.xy + v1.xy;
      r5.xz = r5.xz + r0.xy;
      r1.xy = float2(4,2) * r5.xz;
      r2.w = dot(r1.xy, r1.xy);
      r4.w = cmp(r2.w >= 1);
      r5.xz = r1.xy / r2.ww;
      r3.xy = float2(-1,1) * r5.xz;
      r7.xyzw = r4.wwww ? r3.xyzw : r1.xyzw;
      r1.xy = r7.xy * float2(0.25,0.5) + r7.zw;
      r7.xyzw = RefMipBlurSampler.SampleLevel(RefMipBlurSampler_s, r1.xy, r0.z).xyzw;
      r6.xyz = r7.xyz + r6.xyz;
      r2.z = (int)r2.z + 1;
    }
    r4.xyz = r6.xyz;
    r0.w = (int)r0.w + 1;
  }
  o0.xyz = float3(0.111111112,0.111111112,0.111111112) * r4.xyz;
  o0.w = 1;
  return;
}