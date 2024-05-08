// ---- FNV Hash 1085aa46f9632b15

// ---- Created with 3Dmigoto v1.3.16 on Mon Nov 13 01:20:59 2023

cbuffer rage_matrices : register(b1)
{
  row_major float4x4 gWorld : packoffset(c0);
  row_major float4x4 gWorldView : packoffset(c4);
  row_major float4x4 gWorldViewProj : packoffset(c8);
  row_major float4x4 gViewInverse : packoffset(c12);
  row_major float4x4 gWorldViewProjUnjittered : packoffset(c16);
  row_major float4x4 gWorldViewProjUnjitteredPrev : packoffset(c20);
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

SamplerState LinearSampler_s : register(s2);
SamplerState LinearSampler2_s : register(s3);
SamplerState FullSampler_s : register(s7);
SamplerState DepthSampler_s : register(s8);
SamplerState PointSampler_s : register(s9);
SamplerState PointSampler2_s : register(s10);
SamplerState LinearWrapSampler_s : register(s11);
SamplerState LinearWrapSampler2_s : register(s12);
Texture2D<float4> LinearSampler : register(t2);
Texture2D<float4> LinearSampler2 : register(t3);
Texture2D<float4> FullSampler : register(t7);
Texture2D<float4> DepthSampler : register(t8);
Texture2D<float4> PointSampler : register(t9);
Texture2D<float4> PointSampler2 : register(t10);
Texture2D<float4> LinearWrapSampler : register(t11);
Texture2D<float4> LinearWrapSampler2 : register(t12);


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
  float4 r0,r1,r2,r3,r4,r5,r6,r7;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xy = gFogCompositeTexOffset.xy + v1.xy;
  r0.xyzw = LinearSampler.Sample(LinearSampler_s, r0.xy).xyzw;
  r1.xyzw = LinearSampler2.Sample(LinearSampler2_s, v1.xy).xyzw;
  r0.w = cmp(0 < r1.y);
  r2.xyzw = DepthSampler.Sample(DepthSampler_s, v1.xy).xyzw;
  r1.xy = r2.xx * v2.yx + gViewInverse._m31_m30;
  r2.yz = r1.yx * float2(0.0199999996,0.0199999996) + gFogCompositeParams.zz;
  r3.xyzw = LinearWrapSampler.Sample(LinearWrapSampler_s, r2.yz).xyzw;
  r2.yz = float2(-0.5,-0.5) + r3.yw;
  r3.xy = float2(1,0.300000012) * r2.yz;
  r3.zw = -gFogCompositeParams.zz * float2(15,15) + r1.yx;
  r2.yz = r2.yz * float2(1,0.300000012) + r3.zw;
  r4.xyzw = LinearWrapSampler2.Sample(LinearWrapSampler2_s, r2.yz).xyzw;
  r1.xy = gFogCompositeParams.zz * float2(15,15) + r1.xy;
  r1.xy = r1.xy * float2(0.64546001,0.64546001) + r3.xy;
  r3.xyzw = LinearWrapSampler2.Sample(LinearWrapSampler2_s, r1.xy).xyzw;
  if (r0.w != 0) {
    r5.xyzw = PointSampler2.Sample(PointSampler2_s, v1.xy).xyzw;
    r6.xyzw = PointSampler.Sample(PointSampler_s, v1.xy).xyzw;
    r0.w = cmp(0 != r0.y);
    r0.w = r0.w ? 0 : 1;
    r1.xyz = r4.xyz * r3.xyz;
    r1.xyz = r1.xyz * r6.yyy;
    r1.xyz = r1.xyz * float3(10,10,10) + float3(1,1,1);
    r2.yzw = r1.xyz * r0.xyz;
    r3.xyz = r5.xyz * r5.xyz;
    r4.xyzw = FullSampler.Sample(FullSampler_s, v1.xy).xyzw;
    r3.w = 1 + gProjParams.w;
    r3.w = r3.w + -r4.x;
    r3.w = gProjParams.z / r3.w;
    r4.x = cmp(0 != r5.y);
    r2.x = -r3.w + r2.x;
    r7.y = max(0, r2.x);
    r7.x = r6.x * r6.x;
    r7.z = abs(v2.z) * r7.x;
    r4.yz = r7.yz * r7.xy;
    r4.yz = float2(-78.4330368,-235.299103) * r4.yz;
    r4.yz = exp2(r4.yz);
    r4.yz = r4.xx ? r4.yz : float2(1,1);
    o0.w = r4.x ? r6.y : r0.w;
    r2.xyz = r2.yzw * r5.xyz;
    r2.xyz = r2.xyz + r2.xyz;
    r0.xyz = r0.xyz * r1.xyz + -r2.xyz;
    r0.xyz = r4.zzz * r0.xyz + r2.xyz;
    r0.w = gFogCompositeParams.y * r1.w;
    r1.xyz = r0.www * gFogCompositeDirectionalColor.xyz + gFogCompositeAmbientColor.xyz;
    r0.w = gFogCompositeParams.x * r6.z;
    r0.w = r0.w * r1.w;
    r2.xyz = r0.www * r5.xyz;
    r2.xyz = gFogCompositeDirectionalColor.xyz * r2.xyz;
    r1.xyz = r3.xyz * r1.xyz + r2.xyz;
    r0.xyz = -r1.xyz + r0.xyz;
    o0.xyz = r4.yyy * r0.xyz + r1.xyz;
  } else {
    o0.xyzw = float4(0,0,0,0);
  }
  return;
}