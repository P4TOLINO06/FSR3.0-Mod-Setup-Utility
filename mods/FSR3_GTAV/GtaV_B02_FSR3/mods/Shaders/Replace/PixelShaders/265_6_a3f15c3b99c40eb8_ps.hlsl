// ---- FNV Hash a3f15c3b99c40eb8

// ---- Created with 3Dmigoto v1.3.16 on Mon Nov 20 02:47:58 2023
Texture2D<float4> t15 : register(t15);

Texture2D<float4> t14 : register(t14);

Texture2D<float4> t13 : register(t13);

Texture2D<float4> t11 : register(t11);

Texture2D<float4> t10 : register(t10);

Texture2D<float4> t9 : register(t9);

Texture2D<float4> t7 : register(t7);

Texture2D<float4> t5 : register(t5);

Texture2D<float4> t4 : register(t4);

Texture2D<float4> t3 : register(t3);

SamplerState s15_s : register(s15);

SamplerState s14_s : register(s14);

SamplerState s13_s : register(s13);

SamplerState s11_s : register(s11);

SamplerState s10_s : register(s10);

SamplerState s9_s : register(s9);

SamplerState s7_s : register(s7);

SamplerState s5_s : register(s5);

SamplerState s4_s : register(s4);

SamplerState s3_s : register(s3);

cbuffer cb5 : register(b5)
{
  float4 cb5[91];
}

cbuffer cb2 : register(b2)
{
  float4 cb2[15];
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
  float4 v1 : TEXCOORD0,
  float4 v2 : TEXCOORD1,
  float4 v3 : TEXCOORD3,
  float4 v4 : TEXCOORD4,
  float4 v5 : TEXCOORD5,
  float4 v6 : TEXCOORD6,
  float4 v7 : TEXCOORD7,
  float4 v8 : TEXCOORD8,
  float4 v9 : TEXCOORD9,
  float4 v10 : TEXCOORD10,
  float4 v11 : TEXCOORD11,
  float4 v12 : TEXCOORD12,
  float4 v13 : TEXCOORD13,
  float4 v14 : TEXCOORD14,
  float4 v15 : TEXCOORD15,
  float4 pos : POSITION0,
  out float4 o0 : SV_Target0,
  out float2 motionVectors : SV_Target4)
{

  float4 posCurr = mul(pos.xyzw, gWorldViewProjUnjittered);
  float4 posPrev = mul(pos.xyzw, gWorldViewProjUnjitteredPrev);
  posCurr.xy = posCurr.xy/posCurr.ww;
  posPrev.xy = posPrev.xy/posPrev.ww;
  motionVectors.xy = (posPrev.xy-posCurr.xy) * float2(0.5, -0.5);
  float4 r0,r1,r2,r3,r4,r5,r6,r7,r8;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyz = t5.Sample(s5_s, v1.xy).xyz;
  r1.xyz = t10.SampleLevel(s10_s, v1.xy, 0).xyz;
  r0.xyz = cb2[14].www * r0.xyz;
  r0.w = cmp(0 < cb5[90].w);
  if (r0.w == 0) {
    r0.w = t3.Sample(s3_s, v1.xy).x;
    r0.w = cb5[0].w + -r0.w;
    r0.w = 1 + r0.w;
    r0.w = cb5[0].z / r0.w;
    r2.xyzw = cb5[72].xyxy * float4(-1,-0.5,0.5,-1) + v1.xyxy;
    r3.xyz = t4.Sample(s4_s, r2.xy).xyz;
    r4.xyz = t4.Sample(s4_s, r2.zw).xyz;
    r5.xyzw = cb5[72].xyxy * float4(-0.5,1,1,0.5) + v1.xyxy;
    r6.xyz = t4.Sample(s4_s, r5.xy).xyz;
    r7.xyz = t4.Sample(s4_s, r5.zw).xyz;
    r8.xyz = t4.Sample(s4_s, v1.xy).xyz;
    r3.xyz = r4.xyz + r3.xyz;
    r3.xyz = r3.xyz + r6.xyz;
    r3.xyz = r3.xyz + r7.xyz;
    r4.xyz = float3(0.5,0.5,0.5) * r8.xyz;
    r3.xyz = r8.xyz * float3(0.5,0.5,0.5) + r3.xyz;
    r6.xyz = t9.Sample(s9_s, r2.xy).xyz;
    r2.xyz = t9.Sample(s9_s, r2.zw).xyz;
    r7.xyz = t9.Sample(s9_s, r5.xy).xyz;
    r5.xyz = t9.Sample(s9_s, r5.zw).xyz;
    r8.xyz = t9.Sample(s9_s, v1.xy).xyz;
    r2.xyz = r6.xyz + r2.xyz;
    r2.xyz = r2.xyz + r7.xyz;
    r2.xyz = r2.xyz + r5.xyz;
    r2.xyz = r8.xyz * float3(0.5,0.5,0.5) + r2.xyz;
    r4.xyz = r8.xyz * float3(0.5,0.5,0.5) + r4.xyz;
    r3.xyz = float3(0.111111097,0.111111097,0.111111097) * r3.xyz;
    r2.xyz = r2.xyz * float3(0.111111097,0.111111097,0.111111097) + r3.xyz;
    r1.w = cmp(0.000000 != cb5[4].x);
    r3.xyz = r1.www ? r8.xyz : r4.xyz;
    r2.xyz = r1.www ? r8.xyz : r2.xyz;
    r4.xy = -cb5[3].xz + r0.ww;
    r0.w = saturate(cb5[3].w * r4.y);
    r1.w = saturate(-r4.x * cb5[3].y + 1);
    r0.w = max(r1.w, r0.w);
    r4.xyz = saturate(r0.www * float3(-2.00400805,-2.00400805,-1000) + float3(1,2.00200391,1000));
    r0.w = 1 + -r4.x;
    r0.w = min(r4.y, r0.w);
    r1.w = r4.x + r0.w;
    r2.w = 1 + -r1.w;
    r2.w = min(r4.z, r2.w);
    r1.w = r2.w + r1.w;
    r1.w = 1 + -r1.w;
    r4.yzw = r8.xyz * r0.www;
    r4.xyz = r0.xyz * r4.xxx + r4.yzw;
    r3.xyz = r3.xyz * r2.www + r4.xyz;
    r0.xyz = r2.xyz * r1.www + r3.xyz;
  }
  r0.w = cb5[89].z ? 1 : 0;
  if (r0.w != 0) {
    r2.xyzw = t11.Sample(s11_s, v1.xy).xyzw;
    r3.xyz = r2.xyz + -r0.xyz;
    r0.xyz = r2.www * r3.xyz + r0.xyz;
  } else {
    r2.xyzw = float4(0,0,0,0);
  }
  r3.xyz = t14.Sample(s14_s, v1.xy).xyz;
  r2.xyz = -r3.xyz + r2.xyz;
  r2.xyz = r2.www * r2.xyz + r3.xyz;
  r2.xyz = cb5[89].zzz ? r2.xyz : r3.xyz;
  r2.xyz = r2.xyz + -r0.xyz;
  r0.xyz = cb5[64].xxx * r2.xyz + r0.xyz;
  r1.xyz = v1.www * r1.xyz;
  r0.w = cmp(0 < cb5[75].z);
  if (r0.w != 0) {
    r0.w = t15.SampleLevel(s15_s, v1.xy, 0).x;
    r0.w = r0.w * r0.w;
    r0.w = r0.w * r0.w;
    r0.w = r0.w * r0.w;
    r0.xyz = cb5[46].xyz * r0.www + r0.xyz;
  }
  r2.xyz = t13.Sample(s13_s, v1.xy).xyz;
  r0.w = -cb5[34].x + v1.z;
  r0.w = saturate(cb5[34].y * r0.w);
  r1.w = cb5[34].w + -cb5[34].z;
  r0.w = r0.w * r1.w + cb5[34].z;
  r0.w = -1 + r0.w;
  r0.w = cb5[35].x * r0.w + 1;
  r0.w = cb5[36].w * r0.w;
  r0.xyz = r2.xyz * r0.www + r0.xyz;
  r1.xyz = cb5[7].yyy * r1.xyz;
  r0.xyz = r1.xyz * float3(0.25,0.25,0.25) + r0.xyz;
  r1.xy = float2(-0.5,-0.5) + v1.xy;
  r1.zw = r1.xy + r1.xy;
  r0.w = dot(r1.zw, r1.zw);
  r0.w = -0.0399999991 + r0.w;
  r0.w = 0.200000003 * r0.w;
  r0.w = max(0, r0.w);
  r1.z = cmp(r0.w < 1);
  r1.w = -10 * r0.w;
  r1.w = exp2(r1.w);
  r1.w = 1 + -r1.w;
  r2.xy = float2(-1,-2) + r0.ww;
  r0.w = 10 * r2.y;
  r0.w = exp2(r0.w);
  r2.x = cmp(0 < r2.x);
  r0.w = r2.x ? r0.w : 0;
  r0.w = 0.998000026 + r0.w;
  r0.w = r1.z ? r1.w : r0.w;
  r2.xyz = r0.xyz * r0.www;
  r0.xyz = r2.xyz * float3(-0.700399995,-0.700399995,-0.700399995) + r0.xyz;
  r0.w = dot(r1.xy, r1.xy);
  r0.w = 1 + -r0.w;
  r0.w = log2(r0.w);
  r0.w = cb5[57].y * r0.w;
  r0.w = exp2(r0.w);
  r0.w = saturate(cb5[57].x + r0.w);
  r0.w = saturate(cb5[57].z * r0.w);
  r1.xyz = -cb5[58].xyz + float3(1,1,1);
  r1.xyz = r0.www * r1.xyz + cb5[58].xyz;
  r0.xyz = r1.xyz * r0.xyz;
  r0.xyz = min(float3(65504,65504,65504), r0.xyz);
  r0.w = saturate(v2.x * cb5[14].x + cb5[14].y);
  r1.xyzw = cb5[12].xyzw + -cb5[10].xyzw;
  r1.xyzw = r0.wwww * r1.xyzw + cb5[10].xyzw;
  r2.xyz = cb5[13].xyz + -cb5[11].xyz;
  r2.xyz = r0.www * r2.xyz + cb5[11].xyz;
  r0.w = r1.z * r1.y;
  r1.zw = r2.xy * r1.ww;
  r2.w = r2.z * r1.x + r0.w;
  r2.w = r2.z * r2.w + r1.z;
  r3.x = r2.z * r1.x + r1.y;
  r2.z = r2.z * r3.x + r1.w;
  r2.xz = r2.xw / r2.yz;
  r2.y = r2.z + -r2.x;
  r2.y = 1 / r2.y;
  r0.xyz = v1.zzz * r0.xyz;
  r0.xyz = max(float3(0,0,0), r0.xyz);
  r3.xyz = r1.xxx * r0.xyz + r0.www;
  r3.xyz = r0.xyz * r3.xyz + r1.zzz;
  r1.xyz = r1.xxx * r0.xyz + r1.yyy;
  r0.xyz = r0.xyz * r1.xyz + r1.www;
  r0.xyz = r3.xyz / r0.xyz;
  r0.xyz = r0.xyz + -r2.xxx;
  r0.xyz = saturate(r0.xyz * r2.yyy);
  r0.w = dot(r0.xyz, float3(0.212500006,0.715399981,0.0720999986));
  r0.xyz = r0.xyz + -r0.www;
  r0.xyz = cb5[67].xxx * r0.xyz + r0.www;
  r1.x = saturate(r0.w / cb5[66].w);
  r1.yzw = -cb5[66].xyz + cb5[65].xyz;
  r1.xyz = r1.xxx * r1.yzw + cb5[66].xyz;
  r2.xyz = r1.xyz * r0.xyz;
  r1.w = -cb5[65].w + 1;
  r0.w = -r1.w + r0.w;
  r1.w = 1 + -r1.w;
  r1.w = max(0.00999999978, r1.w);
  r0.w = saturate(r0.w / r1.w);
  r0.xyz = -r0.xyz * r1.xyz + r0.xyz;
  r0.xyz = saturate(r0.www * r0.xyz + r2.xyz);
  r0.xyz = log2(r0.xyz);
  r0.xyz = cb5[67].yyy * r0.xyz;
  r0.xyz = exp2(r0.xyz);
  r0.w = cb5[63].w + v1.y;
  r0.w = cb5[63].y * r0.w;
  r0.w = sin(r0.w);
  r0.w = r0.w * 0.5 + 0.5;
  r1.x = cb5[63].w * 0.5 + v1.y;
  r1.x = cb5[63].z * r1.x;
  r1.x = sin(r1.x);
  r1.x = r1.x * 0.5 + 0.5;
  r1.x = cb5[63].x * r1.x;
  r0.w = r0.w * cb5[63].x + r1.x;
  r0.w = 1 + -r0.w;
  r1.xy = cb5[15].ww * v1.xy;
  r1.xy = r1.xy * float2(1.60000002,0.899999976) + cb5[15].xy;
  r1.xy = frac(r1.xy);
  r1.x = t7.Sample(s7_s, r1.xy).w;
  r1.x = -0.5 + r1.x;
  r1.x = cb5[15].z * r1.x;
  r0.xyz = saturate(r0.xyz * r0.www + r1.xxx);
  o0.w = dot(r0.xyz, float3(0.298999995,0.587000012,0.114));
  o0.xyz = r0.xyz;
  return;
}