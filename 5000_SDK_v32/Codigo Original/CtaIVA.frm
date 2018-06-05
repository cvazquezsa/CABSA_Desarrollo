[Forma]
Clave=CtaIVA
Nombre=Cuentas para Verificar IVA
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
ExpresionesAlMostrar=
ExpresionesAlCerrar=
CarpetaPrincipal=Lista
PosicionInicialIzquierda=262
PosicionInicialArriba=234
PosicionInicialAltura=300
PosicionInicialAncho=500
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)

[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CtaIVA
Fuente={MS Sans Serif, 8, Negro, []}
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
PermiteEditar=S

[Lista.CtaIVA.Cuenta]
Carpeta=Lista
Clave=CtaIVA.Cuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20

[Lista.Cta.Descripcion]
Carpeta=Lista
Clave=Cta.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFuente=Gris

[Lista.CtaIVA.Tipo]
Carpeta=Lista
Clave=CtaIVA.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20

[Lista.CtaIVA.Porcentaje]
Carpeta=Lista
Clave=CtaIVA.Porcentaje
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10

[Lista.Columnas]
Cuenta=131
Descripcion=205
Tipo=57
Porcentaje=76

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
ConCondicion=S
EjecucionCondicion=Asigna(Temp.Texto, ListaBuscarDuplicados(CampoEnLista(CtaIVA:CtaIVA.Cuenta)))<BR>Vacio(Temp.Texto)
EjecucionMensaje=Comillas(Temp.Texto)+<T> Duplicado<T>
EjecucionConError=S

[Acciones.Excel]
Nombre=Excel
Boton=67
NombreDesplegar=Excel
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Enviar/Recibir Excel
ActivoCondicion=Usuario.EnviarExcel
Visible=S

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Excel
Excel=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=CtaIVA.Cuenta
CtaIVA.Cuenta=Cta.Descripcion
Cta.Descripcion=CtaIVA.Tipo
CtaIVA.Tipo=CtaIVA.Porcentaje
CtaIVA.Porcentaje=(Fin)
