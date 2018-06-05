
[Forma]
Clave=ReferenciaOrigen
Icono=0
Modulos=(Todos)
Nombre=Referencia Origen

ListaCarpetas=(Variables)
CarpetaPrincipal=(Variables)
PosicionInicialIzquierda=461
PosicionInicialArriba=202
PosicionInicialAlturaCliente=168
PosicionInicialAncho=306
VentanaTipoMarco=Normal
VentanaPosicionInicial=por Diseño
VentanaEstadoInicial=Normal
ExpresionesAlActivar=Asigna(Info.Modulo, <T>POS<T>)
[(Variables)]
Estilo=Ficha
Clave=(Variables)
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=(Variables)
Fuente={Segoe UI, 8, Blanco, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S
FichaEspacioEntreLineas=0
FichaEspacioNombres=0
FichaColorFondo=$00804000
ListaEnCaptura=(Lista)

PermiteEditar=S


ConFuenteEspecial=S
BarraBotones=S
BarraBtnFuente={Segoe UI, 10, Blanco, []}
BarraBtnFondo=$00804000
BarraBtnPosicion=Abajo
ListaAccionesBB=(Lista)
BarraBtnSize=80
BarraBtnSeparacion=2
BarraBtnSinBisel=S
BarraBtnBisel=0
BarraBtnPaginas=5
[(Variables).Info.MovClaveAfecta]
Carpeta=(Variables)
Clave=Info.MovClaveAfecta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco


[Lista.Columnas]
0=91
1=86
2=-2
3=-2


[(Variables).Info.MovID]
Carpeta=(Variables)
Clave=Info.MovID
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco




[Acciones.Aceptar.Cerrar]
Nombre=Cerrar
Boton=0
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreEnBoton=S
NombreDesplegar=Aceptar
RefrescarDespues=S
Multiple=S
EnBarraHerramientas=S
TipoAccion=Expresion
ListaAccionesMultiples=(Lista)

Activo=S
Visible=S




GuardarAntes=S




[Acciones.Aceptar.Variables Asignar]
Nombre=Variables Asignar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
Activo=S
Visible=S

[Acciones.Aceptar.ListaAccionesMultiples]
(Inicio)=Variables Asignar
Variables Asignar=Cerrar
Cerrar=(Fin)










[Acciones.Separador]
Nombre=Separador
Boton=0
NombreDesplegar=<T>Separador<T>
EsSeparador=S
Activo=S
Visible=S
BarraBtnAncho=5
BarraBtnAlto=75
BarraBtnFondo=Plata
BarraBtnPagina=1


[Acciones.Aceptar.AsignarVariables]
Nombre=AsignarVariables
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
Activo=S
Visible=S

[Acciones.Aceptar.Aceptar]
Nombre=Aceptar
Boton=0
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Acciones.Acepta]
Nombre=Acepta
Boton=0
TeclaFuncion=F1
NombreDesplegar=<T>Aceptar<T>
GuardarAntes=S
RefrescarDespues=S
Multiple=S
ListaAccionesMultiples=(Lista)

Activo=S
Visible=S
BarraBtnAncho=75
BarraBtnMargen=2
BarraBtnAlto=75
BarraBtnFondo=$00C08000
BarraBtnImgAncho=40
BarraBtnImgAlto=40
NombreEnBotonX=S
edBotonSrc=F1.png
BarraBtnPagina=1
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado



[Acciones.Acepta.AsignaVariables]
Nombre=AsignaVariables
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar

[Acciones.Acepta.Cierra]
Nombre=Cierra
Boton=0
TipoAccion=Ventana
ClaveAccion=Aceptar




[Acciones.Acepta.ListaAccionesMultiples]
(Inicio)=AsignaVariables
AsignaVariables=Cierra
Cierra=(Fin)

[(Variables).ListaEnCaptura]
(Inicio)=Info.MovClaveAfecta
Info.MovClaveAfecta=Info.MovID
Info.MovID=(Fin)

[(Variables).ListaAccionesBB]
(Inicio)=Separador
Separador=Acepta
Acepta=(Fin)
