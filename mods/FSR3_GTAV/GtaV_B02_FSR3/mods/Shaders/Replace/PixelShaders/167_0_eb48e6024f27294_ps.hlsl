// ---- FNV Hash eb48e6024f27294

// ---- Created with 3Dmigoto v1.3.16 on Sat Nov 11 18:21:54 2023

cbuffer _Globals : register(b0)
{
  float4 Timer : packoffset(c0);
  float4 tempF1 : packoffset(c1);
  float4 tempF2 : packoffset(c2);
  float4 tempF3 : packoffset(c3);
  float4 ScreenSize : packoffset(c4);
  float4 SourceSize : packoffset(c5);
  float4 DynamicScaling : packoffset(c6);
  float4 Parameters01 : packoffset(c7);
  float4 Parameters02 : packoffset(c8);
  float4 Parameters03 : packoffset(c9);
  float4 Parameters04 : packoffset(c10);
  float4 Parameters05 : packoffset(c11);
  float4 Parameters06 : packoffset(c12);
  float4 Parameters07 : packoffset(c13);
  float4 Parameters08 : packoffset(c14);
  float4 Matrix01[4] : packoffset(c15);
  float4 Matrix02[4] : packoffset(c19);
  float4 Matrix03[4] : packoffset(c23);
  float4 Matrix04[4] : packoffset(c27);
  float4 Matrix05[4] : packoffset(c31);
  float SSAOsplitcount : packoffset(c35) = {2};
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

SamplerState Sampler9_s : register(s8);
Texture2D<float4> Texture0 : register(t0);


// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_POSITION0,
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
  float4 r0,r1,r2,r3,r4,r5;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.y = ScreenSize.y * ScreenSize.z;
  r1.y = SourceSize.x * SourceSize.w;
  r1.x = SourceSize.x;
  r0.x = ScreenSize.y;
  r0.zw = r1.xy * r0.xy;
  r0.zw = min(float2(16,16), r0.zw);
  r0.zw = max(float2(2,2), r0.zw);
  r0.xy = r0.xy + r0.xy;
  r1.xy = float2(0.499900013,0.499900013) + r0.zw;
  r1.xy = (int2)r1.xy;
  r1.zw = floor(r0.zw);
  r1.z = r1.z * r1.w;
  r1.z = 1 / r1.z;
  r0.zw = float2(1,1) / r0.zw;
  r2.xy = r0.zw * float2(0.5,0.5) + float2(-0.5,-0.5);
  r3.xyz = float3(0,0,0);
  r1.w = r2.x;
  r2.z = 0;
  while (true) {
    r2.w = cmp((int)r2.z >= (int)r1.x);
    if (r2.w != 0) break;
    r4.x = r1.w;
    r5.xyz = r3.xyz;
    r2.w = r2.y;
    r3.w = 0;
    while (true) {
      r4.z = cmp((int)r3.w >= (int)r1.y);
      if (r4.z != 0) break;
      r4.y = r2.w;
      r4.yz = r4.xy * r0.xy + v1.xy;
      r4.yzw = Texture0.Sample(Sampler9_s, r4.yz).xyz;
      r4.yzw = max(float3(0,0,0), r4.yzw);
      r5.xyz = r5.xyz + r4.yzw;
      r2.w = r2.w + r0.w;
      r3.w = (int)r3.w + 1;
    }
    r3.xyz = r5.xyz;
    r1.w = r1.w + r0.z;
    r2.z = (int)r2.z + 1;
  }
  r0.xyz = r3.xyz * r1.zzz;
  r0.xyz = max(float3(0,0,0), r0.xyz);
  o0.xyz = min(float3(16384,16384,16384), r0.xyz);
  o0.w = 1;
  return;
}