
[Forma]
Clave=SATCertificadoOrigenLista
Icono=0
BarraHerramientas=S
Modulos=(Todos)
Nombre=<T>Certificado Origen<T>
AccionesTamanoBoton=15x5
AccionesDerecha=S
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal

ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=348
PosicionInicialArriba=196
PosicionInicialAlturaCliente=464
PosicionInicialAncho=744
ListaAcciones=Seleccionar
[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=SATCertificadoOrigen
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

[Lista.SATCertificadoOrigen.TratadoAcuerdo]
Carpeta=Lista
Clave=SATCertificadoOrigen.TratadoAcuerdo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.SATCertificadoOrigen.TipoCertificado]
Carpeta=Lista
Clave=SATCertificadoOrigen.TipoCertificado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.SATCertificadoOrigen.NumCertificado]
Carpeta=Lista
Clave=SATCertificadoOrigen.NumCertificado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.SATCertificadoOrigen.NumeroExportadorConfiable]
Carpeta=Lista
Clave=SATCertificadoOrigen.NumeroExportadorConfiable
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco


[Lista.Columnas]
TratadoAcuerdo=135
TipoCertificado=148
NumCertificado=212
NumeroExportadorConfiable=196























[Forma.ListaAcciones]
(Inicio)=Guardar
Guardar=Excel
Excel=(Fin)

[Acciones.Seleccionar]
Nombre=Seleccionar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Seleccionar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Seleccionar
Activo=S
Visible=S

Antes=S
AntesExpresiones=Asigna(Info.Copiar, Verdadero)<BR>Asigna(Info.Descripcion, SATCertificadoOrigen:SATCertificadoOrigen.NumCertificado)<BR>Asigna(Info.Nombre, SATCertificadoOrigen:SATCertificadoOrigen.NumeroExportadorConfiable)
[Lista.ListaEnCaptura]
(Inicio)=SATCertificadoOrigen.TratadoAcuerdo
SATCertificadoOrigen.TratadoAcuerdo=SATCertificadoOrigen.TipoCertificado
SATCertificadoOrigen.TipoCertificado=SATCertificadoOrigen.NumCertificado
SATCertificadoOrigen.NumCertificado=SATCertificadoOrigen.NumeroExportadorConfiable
SATCertificadoOrigen.NumeroExportadorConfiable=(Fin)
