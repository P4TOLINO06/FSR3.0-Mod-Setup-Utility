// ---- FNV Hash f4b2819e6ab9ec5

// ---- Created with 3Dmigoto v1.3.16 on Mon Nov 13 01:20:59 2023

cbuffer lighting_locals : register(b12)
{
  float4 deferredLightParams[14] : packoffset(c0);
  float4 deferredLightVolumeParams[2] : packoffset(c14);
  float4 deferredLightScreenSize : packoffset(c16);
  float4 deferredProjectionParams : packoffset(c17);
  float3 deferredPerspectiveShearParams0 : packoffset(c18);
  float3 deferredPerspectiveShearParams1 : packoffset(c19);
  float3 deferredPerspectiveShearParams2 : packoffset(c20);
}

cbuffer deferred_lighting_locals : register(b11)
{
  float4 skinColourTweak : packoffset(c0);
  float4 skinParams : packoffset(c1);
  float4 rimLightingParams : packoffset(c2);
  float4 rimLightingMainColourAndIntensity : packoffset(c3);
  float4 rimLightingOffAngleColourAndIntensity : packoffset(c4);
  float3 rimLightingLightDirection : packoffset(c5);
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

SamplerState gDeferredLightSampler_s : register(s2);
SamplerState GBufferTextureSamplerDepthGlobal_s : register(s12);
Texture2D<float4> gDeferredLightSampler : register(t2);
Texture2D<float4> GBufferTextureSamplerDepthGlobal : register(t12);


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
  float4 r0,r1,r2,r3,r4,r5,r6;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xy = deferredLightScreenSize.zw * v0.xy;
  r0.xyzw = gDeferredLightSampler.Sample(gDeferredLightSampler_s, r0.xy).xyzw;
  r0.w = cmp(r0.w >= 0.949999988);
  if (r0.w != 0) {
    r1.xyzw = GBufferTextureSamplerDepthGlobal.Sample(GBufferTextureSamplerDepthGlobal_s, v1.xy).xyzw;
    r0.w = deferredProjectionParams.w + -r1.x;
    r0.w = 1 + r0.w;
    r0.w = deferredProjectionParams.z / r0.w;
    r1.xyzw = gDeferredLightSampler.Sample(gDeferredLightSampler_s, v1.xy).xyzw;
    r1.w = skinParams.w + skinParams.w;
    r0.w = r1.w / r0.w;
    r1.w = cmp(0 < r0.w);
    if (r1.w != 0) {
      r2.xyzw = deferredLightScreenSize.zwzw * r0.wwww;
      r3.xyzw = r2.zwzw * float4(-0.876243174,-0.407413393,-0.181025207,-0.384937197) + v1.xyxy;
      r4.xyzw = gDeferredLightSampler.SampleLevel(gDeferredLightSampler_s, r3.xy, 0).xyzw;
      r0.w = 1 + -r4.w;
      r5.xyz = -r4.xyz + r1.xyz;
      r4.xyz = r0.www * r5.xyz + r4.xyz;
      r4.xyz = skinColourTweak.xyz * r4.xyz;
      r4.xyz = float3(0.0311901998,0.00106171996,0.000313938013) * r4.xyz;
      r4.xyz = r1.xyz * float3(0.395561993,0.817391992,0.930767) + r4.xyz;
      r3.xyzw = gDeferredLightSampler.SampleLevel(gDeferredLightSampler_s, r3.zw, 0).xyzw;
      r0.w = 1 + -r3.w;
      r5.xyz = -r3.xyz + r1.xyz;
      r3.xyz = r0.www * r5.xyz + r3.xyz;
      r3.xyz = skinColourTweak.xyz * r3.xyz;
      r3.xyz = r3.xyz * float3(0.0767408013,0.0273962002,0.00450140983) + r4.xyz;
      r4.xyzw = r2.zwzw * float4(-0.214830294,0.253833592,-0.567938387,-0.773763716) + v1.xyxy;
      r5.xyzw = gDeferredLightSampler.SampleLevel(gDeferredLightSampler_s, r4.xy, 0).xyzw;
      r0.w = 1 + -r5.w;
      r6.xyz = -r5.xyz + r1.xyz;
      r5.xyz = r0.www * r6.xyz + r5.xyz;
      r5.xyz = skinColourTweak.xyz * r5.xyz;
      r3.xyz = r5.xyz * float3(0.0871974975,0.0473178998,0.0143270995) + r3.xyz;
      r4.xyzw = gDeferredLightSampler.SampleLevel(gDeferredLightSampler_s, r4.zw, 0).xyzw;
      r0.w = 1 + -r4.w;
      r5.xyz = -r4.xyz + r1.xyz;
      r4.xyz = r0.www * r5.xyz + r4.xyz;
      r4.xyz = skinColourTweak.xyz * r4.xyz;
      r3.xyz = r4.xyz * float3(0.0315922983,0.00109697005,0.000322965003) + r3.xyz;
      r4.xyzw = r2.zwzw * float4(-0.841088176,0.284752011,0.250466704,-0.778650224) + v1.xyxy;
      r5.xyzw = gDeferredLightSampler.SampleLevel(gDeferredLightSampler_s, r4.xy, 0).xyzw;
      r0.w = 1 + -r5.w;
      r6.xyz = -r5.xyz + r1.xyz;
      r5.xyz = r0.www * r6.xyz + r5.xyz;
      r5.xyz = skinColourTweak.xyz * r5.xyz;
      r3.xyz = r5.xyz * float3(0.0362653993,0.00161670998,0.000436184986) + r3.xyz;
      r4.xyzw = gDeferredLightSampler.SampleLevel(gDeferredLightSampler_s, r4.zw, 0).xyzw;
      r0.w = 1 + -r4.w;
      r5.xyz = -r4.xyz + r1.xyz;
      r4.xyz = r0.www * r5.xyz + r4.xyz;
      r4.xyz = skinColourTweak.xyz * r4.xyz;
      r3.xyz = r4.xyz * float3(0.0412312001,0.00246015005,0.000571736018) + r3.xyz;
      r4.xyzw = r2.zwzw * float4(0.224158794,0.0229107104,0.0774180964,0.88098371) + v1.xyxy;
      r5.xyzw = gDeferredLightSampler.SampleLevel(gDeferredLightSampler_s, r4.xy, 0).xyzw;
      r0.w = 1 + -r5.w;
      r6.xyz = -r5.xyz + r1.xyz;
      r5.xyz = r0.www * r6.xyz + r5.xyz;
      r5.xyz = skinColourTweak.xyz * r5.xyz;
      r3.xyz = r5.xyz * float3(0.100745,0.0887245983,0.0460233018) + r3.xyz;
      r4.xyzw = gDeferredLightSampler.SampleLevel(gDeferredLightSampler_s, r4.zw, 0).xyzw;
      r0.w = 1 + -r4.w;
      r5.xyz = -r4.xyz + r1.xyz;
      r4.xyz = r0.www * r5.xyz + r4.xyz;
      r4.xyz = skinColourTweak.xyz * r4.xyz;
      r3.xyz = r4.xyz * float3(0.0365110002,0.00165053003,0.000442538003) + r3.xyz;
      r4.xyzw = r2.zwzw * float4(-0.395173401,0.870459378,0.615413785,0.657610416) + v1.xyxy;
      r5.xyzw = gDeferredLightSampler.SampleLevel(gDeferredLightSampler_s, r4.xy, 0).xyzw;
      r0.w = 1 + -r5.w;
      r6.xyz = -r5.xyz + r1.xyz;
      r5.xyz = r0.www * r6.xyz + r5.xyz;
      r5.xyz = skinColourTweak.xyz * r5.xyz;
      r3.xyz = r5.xyz * float3(0.0318328999,0.00111868,0.00032842299) + r3.xyz;
      r4.xyzw = gDeferredLightSampler.SampleLevel(gDeferredLightSampler_s, r4.zw, 0).xyzw;
      r0.w = 1 + -r4.w;
      r5.xyz = -r4.xyz + r1.xyz;
      r4.xyz = r0.www * r5.xyz + r4.xyz;
      r4.xyz = skinColourTweak.xyz * r4.xyz;
      r3.xyz = r4.xyz * float3(0.0354101993,0.00150453998,0.000414361013) + r3.xyz;
      r2.xyzw = r2.xyzw * float4(0.678331673,0.170818299,0.631573081,-0.434071213) + v1.xyxy;
      r4.xyzw = gDeferredLightSampler.SampleLevel(gDeferredLightSampler_s, r2.xy, 0).xyzw;
      r0.w = 1 + -r4.w;
      r5.xyz = -r4.xyz + r1.xyz;
      r4.xyz = r0.www * r5.xyz + r4.xyz;
      r4.xyz = skinColourTweak.xyz * r4.xyz;
      r3.xyz = r4.xyz * float3(0.050569199,0.00524900993,0.000862699002) + r3.xyz;
      r2.xyzw = gDeferredLightSampler.SampleLevel(gDeferredLightSampler_s, r2.zw, 0).xyzw;
      r0.w = 1 + -r2.w;
      r4.xyz = -r2.xyz + r1.xyz;
      r2.xyz = r0.www * r4.xyz + r2.xyz;
      r2.xyz = skinColourTweak.xyz * r2.xyz;
      r1.xyz = r2.xyz * float3(0.0451515988,0.00341053004,0.00068832899) + r3.xyz;
    }
    r1.xyz = r1.xyz + -r0.xyz;
    o0.xyz = skinParams.xxx * r1.xyz + r0.xyz;
    o0.w = 1;
  } else {
    o0.xyz = r0.xyz;
    o0.w = 1;
  }
  return;
}