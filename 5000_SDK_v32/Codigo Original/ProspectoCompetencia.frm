
[Forma]
Clave=ProspectoCompetencia
Icono=0
Modulos=(Todos)
Nombre=Productos a Evaluar

ListaCarpetas=ProspectoCompetencia
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
CarpetaPrincipal=ProspectoCompetencia
PosicionInicialIzquierda=456
PosicionInicialArriba=191
PosicionInicialAlturaCliente=384
PosicionInicialAncho=367
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
[ProspectoCompetencia]
Estilo=Hoja
Clave=ProspectoCompetencia
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ProspectoCompetencia
Fuente={Tahoma, 8, Negro, []}
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

HojaTitulos=S
[ProspectoCompetencia.ProspectoCompetencia.Descripcion]
Carpeta=ProspectoCompetencia
Clave=ProspectoCompetencia.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=40
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y Cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S


[ProspectoCompetencia.Columnas]
Descripcion=273






Competencia=64
[Acciones.EnviarExcel]
Nombre=EnviarExcel
Boton=67
NombreDesplegar=EnviarExcel
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
Activo=S
Visible=S













[ProspectoCompetencia.ProspectoCompetencia.Competencia]
Carpeta=ProspectoCompetencia
Clave=ProspectoCompetencia.Competencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro




[ProspectoCompetencia.ListaEnCaptura]
(Inicio)=ProspectoCompetencia.Competencia
ProspectoCompetencia.Competencia=ProspectoCompetencia.Descripcion
ProspectoCompetencia.Descripcion=(Fin)









[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=EnviarExcel
EnviarExcel=(Fin)
