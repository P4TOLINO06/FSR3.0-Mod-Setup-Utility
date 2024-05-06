// ---- FNV Hash 24f47a0038840f37

// ---- Created with 3Dmigoto v1.3.16 on Thu Nov 23 17:29:54 2023
Texture2D<float4> t14 : register(t14);

Texture2D<float4> t10 : register(t10);

Texture2D<float4> t9 : register(t9);

Texture2D<float4> t8 : register(t8);

Texture2D<float4> t7 : register(t7);

Texture2D<float4> t6 : register(t6);

Texture2D<float4> t5 : register(t5);

Texture2D<float4> t4 : register(t4);

Texture2D<float4> t3 : register(t3);

Texture2D<float4> t0 : register(t0);

SamplerState s14_s : register(s14);

SamplerState s10_s : register(s10);

SamplerState s9_s : register(s9);

SamplerState s8_s : register(s8);

SamplerState s7_s : register(s7);

SamplerState s6_s : register(s6);

SamplerState s5_s : register(s5);

SamplerState s4_s : register(s4);

SamplerState s3_s : register(s3);

SamplerState s0_s : register(s0);

cbuffer cb11 : register(b11)
{
  float4 cb11[11];
}

cbuffer cb12 : register(b12)
{
  float4 cb12[5];
}

cbuffer cb5 : register(b5)
{
  float4 cb5[4];
}

cbuffer cb3 : register(b3)
{
  float4 cb3[50];
}

cbuffer cb2 : register(b2)
{
  float4 cb2[14];
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
  float4 v3 : TEXCOORD2,
  float4 v4 : TEXCOORD3,
  float4 v5 : TEXCOORD4,
  float4 v6 : TEXCOORD5,
  float3 v7 : TEXCOORD6,
  float4 pos : POSITION0,
  out float4 o0 : SV_Target0,
  out float4 o1 : SV_Target1,
  out float4 o2 : SV_Target2,
  out float4 o3 : SV_Target3,
  out float2 motionVectors : SV_Target4)
{

  float4 posCurr = mul(pos.xyzw, gWorldViewProjUnjittered);
  float4 posPrev = mul(pos.xyzw, gWorldViewProjUnjitteredPrev);
  posCurr.xy = posCurr.xy/posCurr.ww;
  posPrev.xy = posPrev.xy/posPrev.ww;
  motionVectors.xy = (posPrev.xy-posCurr.xy) * float2(0.5, -0.5);
  float4 r0,r1,r2,r3,r4,r5,r6,r7,r8,r9;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xy = cb11[0].xx * v1.zw;
  r0.zw = cb11[6].ww * v1.zw;
  r1.xyzw = t5.Sample(s5_s, v1.zw).xyzw;
  r2.xyzw = t0.Sample(s0_s, r0.xy).xyzw;
  r0.xy = t8.Sample(s8_s, v1.xy).xy;
  r3.xy = t7.Sample(s7_s, v7.xy).xy;
  r3.z = min(cb11[3].x, 0.5);
  r3.xy = r3.xy + -r0.xy;
  r0.xy = r3.zz * r3.xy + r0.xy;
  r0.xy = r0.xy * float2(2,2) + float2(-1,-1);
  r3.x = dot(r0.xy, r0.xy);
  r3.x = 1 + -r3.x;
  r3.x = sqrt(abs(r3.x));
  r3.y = max(cb11[9].x, 0.00100000005);
  r0.xy = r3.yy * r0.xy;
  r3.yzw = v6.yxz * r0.yyy;
  r3.yzw = r0.xxx * v5.yxz + r3.yzw;
  r3.xyz = r3.xxx * v2.yxz + r3.yzw;
  r0.x = dot(r3.xyz, r3.xyz);
  r0.x = rsqrt(r0.x);
  r3.xyw = r3.xyz * r0.xxx;
  r4.xyzw = t9.Sample(s9_s, r0.zw).xyzw;
  r4.xy = r4.xy * r4.xy;
  r0.y = dot(r4.xyz, cb11[6].xyz);
  r0.z = cb11[5].y * r0.y;
  r0.w = cb11[5].x * r4.w;
  r4.x = dot(v4.xyz, v4.xyz);
  r4.x = rsqrt(r4.x);
  r5.xyz = v4.xyz * r4.xxx;
  r4.y = cmp(0 < cb11[1].x);
  if (r4.y != 0) {
    r5.x = saturate(dot(r3.yxw, r5.xyz));
    r5.y = 0;
    r5.xyz = t10.Sample(s10_s, r5.xy).xyz;
  } else {
    r5.xyz = cb11[0].yzw;
  }
  r4.y = dot(r5.xyz, float3(0.212599993,0.715200007,0.0722000003));
  r6.xyzw = float4(0.075000003,0.075000003,0.075000003,0.075000003) + r5.xyyz;
  r6.xyzw = cmp(r5.yxzy < r6.xyzw);
  r4.z = r6.y ? r6.x : 0;
  r4.z = r6.z ? r4.z : 0;
  r4.z = r6.w ? r4.z : 0;
  r5.w = cmp(0.779999971 < r4.y);
  r4.z = r5.w ? r4.z : 0;
  r6.xyz = float3(0.796000004,0.796000004,0.796000004) * r5.xyz;
  r5.xyz = r4.zzz ? r6.xyz : r5.xyz;
  r6.xyz = r5.xyz * r2.xyz;
  r7.xy = cb11[10].zz * v1.xy;
  r8.xyzw = t3.Sample(s3_s, r7.xy).xyzw;
  r7.xyz = t4.Sample(s4_s, r7.xy).xyz;
  r4.z = saturate(v7.z + v7.z);
  r5.w = -0.5 + v7.z;
  r5.w = saturate(r5.w + r5.w);
  r4.z = r4.z * r8.w;
  r5.xyz = -r2.xyz * r5.xyz + r8.xyz;
  r5.xyz = r4.zzz * r5.xyz + r6.xyz;
  r6.xyz = r7.xyz + -r5.xyz;
  r5.xyz = r5.www * r6.xyz + r5.xyz;
  r1.w = cb11[2].w * r1.w;
  r1.xyz = cb11[2].xyz * r1.xyz + -r5.xyz;
  r2.xyz = r1.www * r1.xyz + r5.xyz;
  r1.xyzw = v3.xxxw * r2.xyzw;
  r2.xy = cb2[12].zy * v3.xx;
  r2.z = saturate(cb3[49].w + cb2[13].z);
  r5.y = r2.y * r2.z;
  r0.z = v3.x * r0.z;
  r0.z = v2.w * r0.z;
  r2.yz = -cb11[3].zz + float2(1,2);
  r2.w = v3.z * r2.y;
  r5.zw = v7.xy * r2.zz;
  r6.xyz = t6.Sample(s6_s, r5.zw).xyz;
  r2.z = t6.Load(float4(0,0,0,0)).w;
  r4.z = cmp(0.49000001 < r2.z);
  r2.z = cmp(r2.z < 0.50999999);
  r2.z = r2.z ? r4.z : 0;
  r4.z = saturate(cb11[3].y * 2.5 + -1.5);
  r4.z = r6.x * r4.z;
  r7.y = 1.29999995 * r4.z;
  r7.z = r6.y;
  r7.yz = r2.zz ? r7.yz : r6.yz;
  r2.z = t6.Sample(s6_s, r5.zw, int2(0, 0)).x;
  r4.z = t6.Sample(s6_s, r5.zw, int2(0, 0)).x;
  r6.y = t6.Sample(s6_s, r5.zw, int2(0, 0)).x;
  r5.z = t6.Sample(s6_s, r5.zw, int2(0, 0)).x;
  r2.z = 0.333332986 * r2.z;
  r4.z = 0.333332986 * r4.z;
  r5.w = 0.333332986 * r6.y;
  r5.z = 0.333332986 * r5.z;
  r4.y = -0.0170000009 + r4.y;
  r6.y = dot(cb11[4].xyz, float3(0.212599993,0.715200007,0.0722000003));
  r4.y = cmp(r4.y < r6.y);
  r2.z = r4.y ? r2.z : -r2.z;
  r4.z = r4.y ? r4.z : -r4.z;
  r5.w = r4.y ? r5.w : -r5.w;
  r4.y = r4.y ? r5.z : -r5.z;
  r4.y = r4.y + -r5.w;
  r8.x = r4.y + r4.y;
  r2.z = r4.z + -r2.z;
  r8.y = r2.z + r2.z;
  r2.z = -r8.x * r8.x + 1;
  r2.z = -r8.y * r8.y + r2.z;
  r8.z = sqrt(r2.z);
  r6.yzw = max(float3(-1,-1,-1), r8.xyz);
  r6.yzw = min(float3(1,1,1), r6.yzw);
  r8.xyz = -cb3[0].xyz + float3(0,0,-1);
  r8.xyz = cb11[8].www * r8.xyz + cb3[0].xyz;
  r4.xyz = v4.xyz * r4.xxx + -r8.xyz;
  r2.z = dot(r4.xyz, r4.xyz);
  r2.z = rsqrt(r2.z);
  r9.xyz = r4.xyz * r2.zzz;
  r4.xyz = -r4.xyz * r2.zzz + float3(1,1,1);
  r4.xyz = sqrt(r4.xyz);
  r2.z = dot(r6.yzw, r4.xyz);
  r4.x = r6.x * r2.z;
  r4.y = cb11[3].z * cb5[3].z;
  r2.z = -r6.x * r2.z + r7.z;
  r7.x = r4.y * r2.z + r4.x;
  r4.xy = cb11[3].xx * r7.xy;
  r2.z = v3.z * r2.y + -1;
  r2.y = r2.y * r2.z + 1;
  r2.z = r4.x * r2.y;
  r6.xyz = cb11[4].xyz * cb11[3].yyy;
  r6.xyz = r6.xyz * float3(1.07558298,0.994183004,0.930234015) + -r1.xyz;
  r1.xyz = r2.zzz * r6.xyz + r1.xyz;
  r2.z = cb11[3].x * r2.w;
  r6.xyz = r7.zzz + -r1.xyz;
  r1.xyz = r2.zzz * r6.xyz + r1.xyz;
  r2.y = -r4.y * r2.y + 1;
  r4.x = r2.y * r0.z;
  r2.z = cmp(0 < cb11[7].y);
  if (r2.z != 0) {
    r2.z = cb11[7].y * cb11[3].w;
    r2.z = v3.x * r2.z;
    r0.y = r2.z * r0.y;
    r2.z = cmp(1.5 < abs(cb11[1].x));
    if (r2.z != 0) {
      r6.x = saturate(dot(r3.yxw, -r8.xyz));
      r6.y = 0;
      r6.xyz = t14.Sample(s14_s, r6.xy).xyz;
    } else {
      r6.xyz = cb11[8].xyz;
    }
    r6.xyz = r6.xyz * r0.yyy;
    r0.y = dot(r3.yxw, r9.xyz);
    r0.y = saturate(0 + r0.y);
    r2.z = cb11[7].x * r4.w + 0;
    r0.y = log2(r0.y);
    r0.y = r2.z * r0.y;
    r0.y = exp2(r0.y);
    r1.xyz = r6.xyz * r0.yyy + r1.xyz;
  }
  r1.xyz = min(float3(240,240,240), r1.xyz);
  r6.w = cb2[12].x * r1.w;
  r3.xyw = r3.xyw * float3(0.5,0.5,0.5) + float3(0.5,0.5,0.5);
  r7.xyz = float3(256,256,256) * r3.xyw;
  r7.xyz = floor(r7.yxz);
  r3.xyw = r3.xyw * float3(256,256,256) + -r7.yxz;
  r3.xyw = float3(8,8,4) * r3.xyw;
  r3.xyw = floor(r3.xyw);
  r0.y = dot(r3.xyw, float3(4,32,1));
  o1.w = 0.00392200006 * r0.y;
  o1.xyz = float3(0.00390599994,0.00390599994,0.00390599994) * r7.xyz;
  r4.y = 0.00195299997 * r0.w;
  r5.x = cb2[12].z * v3.x + cb3[45].w;
  r0.yw = float2(0.5,0.5) * r5.xy;
  o3.xy = sqrt(r0.yw);
  r0.x = r3.z * r0.x + -0.349999994;
  r0.x = saturate(1.53846204 * r0.x);
  r0.x = cb5[3].z * r0.x;
  r0.y = -cb2[13].z + 1;
  r0.x = r0.x * r0.y;
  r0.x = r0.x * r2.x;
  r0.y = r4.x * -0.5 + 1;
  r0.y = r0.x * r0.y;
  r0.y = r0.y * -0.5 + 1;
  r6.xyz = r1.xyz * r0.yyy;
  r0.y = saturate(r2.y * r0.z + 0.400000006);
  r0.yz = r0.yy * float2(0.5,0.488281012) + -r4.xy;
  r0.yz = max(float2(0,0), r0.yz);
  r0.xy = r0.yz * r0.xx + r4.xy;
  o2.xy = sqrt(r0.xy);
  o0.xyzw = cb12[4].xxxx ? v3.xyzw : r6.xyzw;
  o2.z = cb11[4].w;
  o2.w = 1;
  o3.zw = float2(0,1.00188398);
  return;
}