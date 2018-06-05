
[Forma]
Clave=EmpresaCE
Icono=0
BarraHerramientas=S
Modulos=(Todos)
Nombre=Configuración - Comercio Exterior
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=378
PosicionInicialArriba=217
PosicionInicialAlturaCliente=263
PosicionInicialAncho=602
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
ListaAcciones=Guardar
Comentarios=Info.Empresa
[Lista]
Estilo=Ficha
PestanaNombre=Generales
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EmpresaCE
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
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
FiltroRespetar=S
FiltroTipo=General
FiltroGeneral=EmpresaCE.Empresa = <T>{Info.Empresa}<T>
[Lista.EmpresaCE.TipoOperacion]
Carpeta=Lista
Clave=EmpresaCE.TipoOperacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=40
ColorFondo=Blanco

[Lista.EmpresaCE.ClavePedimento]
Carpeta=Lista
Clave=EmpresaCE.ClavePedimento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=40
ColorFondo=Blanco

[Lista.EmpresaCE.CertificadoOrigen]
Carpeta=Lista
Clave=EmpresaCE.CertificadoOrigen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=40
ColorFondo=Blanco

[Lista.EmpresaCE.NumCertificadoOrigen]
Carpeta=Lista
Clave=EmpresaCE.NumCertificadoOrigen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=40
ColorFondo=Blanco

[Lista.EmpresaCE.NumeroExportadorConfiable]
Carpeta=Lista
Clave=EmpresaCE.NumeroExportadorConfiable
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=40
ColorFondo=Blanco

[Acciones.Guardar]
Nombre=Guardar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S





[Lista.ListaEnCaptura]
(Inicio)=EmpresaCE.TipoOperacion
EmpresaCE.TipoOperacion=EmpresaCE.ClavePedimento
EmpresaCE.ClavePedimento=EmpresaCE.CertificadoOrigen
EmpresaCE.CertificadoOrigen=EmpresaCE.NumCertificadoOrigen
EmpresaCE.NumCertificadoOrigen=EmpresaCE.NumeroExportadorConfiable
EmpresaCE.NumeroExportadorConfiable=(Fin)

[Lista.Columnas]
TratadoAcuerdo=135
TipoCertificado=148
NumCertificado=212
NumeroExportadorConfiable=196
