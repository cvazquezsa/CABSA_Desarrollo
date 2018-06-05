[Forma]
Clave=TratadoComercial
Nombre=Tratados Comerciales
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=473
PosicionInicialArriba=308
PosicionInicialAlturaCliente=380
PosicionInicialAncho=333
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=TratadoComercial
Fuente={Tahoma, 8, Negro, []}
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=TratadoComercial.TratadoComercial
CarpetaVisible=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S

[Lista.TratadoComercial.TratadoComercial]
Carpeta=Lista
Clave=TratadoComercial.TratadoComercial
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro
EditarConBloqueo=N

[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Lista.Columnas]
TratadoComercial=304

[Acciones.TratadoComercialPais]
Nombre=TratadoComercialPais
Boton=47
NombreEnBoton=S
NombreDesplegar=&Paises
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=TratadoComercialPais
Activo=S
ConCondicion=S
EjecucionCondicion=ConDatos(TratadoComercial:TratadoComercial.TratadoComercial)
Antes=S
AntesExpresiones=Asigna(Info.TratadoComercial, TratadoComercial:TratadoComercial.TratadoComercial)
Visible=S

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=TratadoComercialPais
TratadoComercialPais=(Fin)
