
[Forma]
Clave=DatosVueloDF
Icono=0
Modulos=(Todos)
Nombre=Datos del Vuelo

ListaCarpetas=Principal
CarpetaPrincipal=Principal
PosicionInicialIzquierda=374
PosicionInicialArriba=203
PosicionInicialAlturaCliente=425
PosicionInicialAncho=852
VentanaTipoMarco=Ninguno
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
BarraAyudaBold=S
VentanaColor=$00804000
BarraAcciones=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Cierra
VentanaSinIconosMarco=S
[Principal]
Estilo=Ficha
Clave=Principal
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=POSL
Fuente={Segoe UI, 10, Blanco, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=$00804000
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco

CarpetaVisible=S

PermiteEditar=S








Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
ListaEnCaptura=(Lista)
ConFuenteEspecial=S
BarraBotones=S
ListaAccionesBB=(Lista)
BarraBtnFuente={Segoe UI, 10, Blanco, []}
BarraBtnFondo=$00804000
BarraBtnPosicion=Abajo
BarraBtnSize=80
BarraBtnSeparacion=2
BarraBtnSinBisel=S
BarraBtnBisel=0
BarraBtnPaginas=1
FiltroGeneral=POSL.ID = <T>{Info.IDTexto}<T>
[Acciones.Aceptar]
Nombre=Aceptar
Boton=0
NombreDesplegar=&Aceptar
Activo=S
Visible=S

TipoAccion=Ventana
ClaveAccion=Cerrar
GuardarAntes=S
[Acciones.Aceptar.Aceptar]
Nombre=Aceptar
Boton=0
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S


[Acciones.Aceptar.&Cerrar]
Nombre=&Cerrar
Boton=0
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Acciones.Aceptar.ListaAccionesMultiples]
(Inicio)=Aceptar
Aceptar=&Cerrar
&Cerrar=(Fin)

[Acciones.Cerrar]
Nombre=Cerrar
Boton=0
NombreDesplegar=&Cerrar
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S





























[Principal.POSL.NombreDF]
Carpeta=Principal
Clave=POSL.NombreDF
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Principal.POSL.ApellidosDF]
Carpeta=Principal
Clave=POSL.ApellidosDF
Editar=S
ValidaNombre=S
3D=S
Tamano=60
ColorFondo=Blanco

[Principal.POSL.PasaporteDF]
Carpeta=Principal
Clave=POSL.PasaporteDF
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Principal.POSL.NacionalidadDF]
Carpeta=Principal
Clave=POSL.NacionalidadDF
Editar=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Principal.POSL.NoVueloDF]
Carpeta=Principal
Clave=POSL.NoVueloDF
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Principal.POSL.AerolineaDF]
Carpeta=Principal
Clave=POSL.AerolineaDF
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Plata

IgnoraFlujo=S
[Principal.POSL.OrigenDF]
Carpeta=Principal
Clave=POSL.OrigenDF
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Plata

IgnoraFlujo=S
[Principal.POSL.DestinoDF]
Carpeta=Principal
Clave=POSL.DestinoDF
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Plata















IgnoraFlujo=S









[Acciones.F1]
Nombre=F1
Boton=0
TeclaFuncion=F1
NombreDesplegar=Guardar y Cerrar
GuardarAntes=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S
BarraBtnFondo=$00C08000
edBotonSrc=F1.png
NombreEnBoton=S
NombreEnBotonX=S

BarraBtnAncho=75
BarraBtnMargen=2
BarraBtnAlto=75
BarraBtnImgAncho=40
BarraBtnImgAlto=40
BarraBtnPagina=1
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado


















Multiple=S
ListaAccionesMultiples=Validacion
[Acciones.Separador]
Nombre=Separador
Boton=0
EsSeparador=S
TipoAccion=Expresion
Activo=S
Visible=S
BarraBtnAncho=375
BarraBtnAlto=75
BarraBtnFondo=Negro
BarraBtnPagina=1















[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Cerrar
Cerrar=(Fin)





[Acciones.F1.Validacion]
Nombre=Validacion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S


Expresion=Si<BR>  SQL(<T>EXEC spPOSDatosVueloVerificar :tID, 0<T>, Info.IDTexto)<BR>Entonces<BR>  Si(Confirmacion(<T>No ha Completado los Datos de Vuelo, Si Continua no Podrá Terminar la Venta, ¿ Desea Continuar ?<T>,BotonSi, BotonNo)=BotonSi, Forma.Accion(<T>Cierra<T>))<BR>Sino<BR>  Forma.Accion(<T>Cierra<T>)<BR>Fin
[Acciones.F1.ListaAccionesMultiples]
(Inicio)=Validacion
Validacion=Cerrar
Cerrar=(Fin)





[Acciones.Cierra]
Nombre=Cierra
Boton=0
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S





[Principal.ListaEnCaptura]
(Inicio)=POSL.NombreDF
POSL.NombreDF=POSL.ApellidosDF
POSL.ApellidosDF=POSL.PasaporteDF
POSL.PasaporteDF=POSL.NacionalidadDF
POSL.NacionalidadDF=POSL.NoVueloDF
POSL.NoVueloDF=POSL.AerolineaDF
POSL.AerolineaDF=POSL.OrigenDF
POSL.OrigenDF=POSL.DestinoDF
POSL.DestinoDF=(Fin)

[Principal.ListaAccionesBB]
(Inicio)=Separador
Separador=F1
F1=(Fin)
