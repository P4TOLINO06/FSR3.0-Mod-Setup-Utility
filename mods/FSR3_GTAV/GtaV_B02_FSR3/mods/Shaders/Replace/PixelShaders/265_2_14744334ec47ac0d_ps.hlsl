// ---- FNV Hash 14744334ec47ac0d

// ---- Created with 3Dmigoto v1.3.16 on Mon Nov 20 02:47:58 2023
Texture2D<float4> t5 : register(t5);

SamplerState s5_s : register(s5);

cbuffer cb5 : register(b5)
{
  float4 cb5[72];
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
  float4 r0,r1,r2;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyzw = t5.Sample(s5_s, v1.xy).xyzw;
  r0.xyzw = float4(0.227029994,0.227029994,0.227029994,0.227029994) * r0.xyzw;
  r1.xyzw = cb5[71].xyxy * float4(0,1.38461995,0,-1.38461995) + v1.xyxy;
  r2.xyzw = t5.Sample(s5_s, r1.xy).xyzw;
  r1.xyzw = t5.Sample(s5_s, r1.zw).xyzw;
  r0.xyzw = r2.xyzw * float4(0.316219985,0.316219985,0.316219985,0.316219985) + r0.xyzw;
  r0.xyzw = r1.xyzw * float4(0.316219985,0.316219985,0.316219985,0.316219985) + r0.xyzw;
  r1.xyzw = cb5[71].xyxy * float4(0,3.23077011,0,-3.23077011) + v1.xyxy;
  r2.xyzw = t5.Sample(s5_s, r1.xy).xyzw;
  r1.xyzw = t5.Sample(s5_s, r1.zw).xyzw;
  r0.xyzw = r2.xyzw * float4(0.0702700019,0.0702700019,0.0702700019,0.0702700019) + r0.xyzw;
  r0.xyzw = r1.xyzw * float4(0.0702700019,0.0702700019,0.0702700019,0.0702700019) + r0.xyzw;
  o0.xyzw = min(float4(1638.40002,1638.40002,1638.40002,1638.40002), r0.xyzw);
  return;
}