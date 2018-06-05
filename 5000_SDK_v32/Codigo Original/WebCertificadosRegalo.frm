
[Forma]
Clave=WebCertificadosRegalo
Icono=0
BarraHerramientas=S
Modulos=(Todos)
MovModulo=(Todos)
Nombre=Certificados Regalo Web
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=562
PosicionInicialArriba=282
PosicionInicialAlturaCliente=273
PosicionInicialAncho=366
ListaAcciones=(Lista)
[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=WebCertificadosRegalo
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

CarpetaVisible=S

Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroGeneral=Sucursal = {Info.Clave}
FiltroRespetar=S
FiltroTipo=General
[Lista.WebCertificadosRegalo.Monto]
Carpeta=Lista
Clave=WebCertificadosRegalo.Monto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.WebCertificadosRegalo.Articulo]
Carpeta=Lista
Clave=WebCertificadosRegalo.Articulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.WebCertificadosRegalo.SubCuenta]
Carpeta=Lista
Clave=WebCertificadosRegalo.SubCuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.Columnas]
Monto=64
Articulo=124
SubCuenta=129

Descripcion1=244
0=79
1=427
2=-2

[Acciones.Guardar]
Nombre=Guardar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y Cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Acciones.Cerrar]
Nombre=Cerrar
Boton=21
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S



EspacioPrevio=S







[FormaExtraValor.Columnas]
VerCampo=285
VerValor=316

[SituacionCta.Columnas]
0=188
1=148
2=-2
3=-2
4=-2

[(Carpeta Abrir).Columnas]
0=131
1=282


























[Lista.ListaEnCaptura]
(Inicio)=WebCertificadosRegalo.Monto
WebCertificadosRegalo.Monto=WebCertificadosRegalo.Articulo
WebCertificadosRegalo.Articulo=WebCertificadosRegalo.SubCuenta
WebCertificadosRegalo.SubCuenta=(Fin)





[Forma.ListaAcciones]
(Inicio)=Guardar
Guardar=Cerrar
Cerrar=(Fin)
