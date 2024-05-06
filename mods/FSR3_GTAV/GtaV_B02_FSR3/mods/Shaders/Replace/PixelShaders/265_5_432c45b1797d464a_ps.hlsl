// ---- FNV Hash 432c45b1797d464a

// ---- Created with 3Dmigoto v1.3.16 on Mon Nov 20 02:47:58 2023
Texture2D<float4> t5 : register(t5);

SamplerState s5_s : register(s5);

cbuffer cb5 : register(b5)
{
  float4 cb5[73];
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
  float4 r0,r1;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyzw = float4(0,0,0,0);
  while (true) {
    r1.x = cmp((int)r0.w >= 96);
    if (r1.x != 0) break;
    r1.x = (int)r0.w;
    r1.y = r1.x * -0.0104166698 + 1;
    r1.y = r1.y * r1.y;
    r1.xz = cb5[42].xy * r1.xx;
    r1.xz = cb5[72].xy * r1.xz + v1.xy;
    r1.xzw = t5.SampleLevel(s5_s, r1.xz, 0).xyz;
    r0.xyz = r1.xzw * r1.yyy + r0.xyz;
    r0.w = (int)r0.w + 1;
  }
  r0.xyz = float3(0.0416666716,0.0416666716,0.0416666716) * r0.xyz;
  r0.w = cmp(0 < cb5[35].y);
  r1.xy = float2(-0.5,-0.5) + v1.yx;
  r0.w = r0.w ? abs(r1.x) : abs(r1.y);
  r0.w = r0.w + r0.w;
  r1.x = cb5[35].w + -cb5[35].z;
  r0.w = r1.x * r0.w + cb5[35].z;
  r0.w = r0.w * r0.w;
  o0.xyz = r0.xyz * r0.www;
  o0.w = 1;
  return;
}